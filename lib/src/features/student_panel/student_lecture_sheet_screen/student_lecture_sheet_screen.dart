import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_compress_image.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/youtube_video_screen.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../student_home_screen/model/student_content_model.dart';
import 'widget/student_lecture_sheet_widget.dart';

class StudentLectureSheetScreen extends StatefulWidget {
  final bool? isBackIc;
  const StudentLectureSheetScreen({
    super.key,
    this.isBackIc = true,
  });

  @override
  State<StudentLectureSheetScreen> createState() => _StudentLectureSheetScreenState();
}

class _StudentLectureSheetScreenState extends State<StudentLectureSheetScreen> {

  final TextEditingController subjectCon = TextEditingController();
  final TextEditingController coverImageCon = TextEditingController();
  final TextEditingController descriptionCon = TextEditingController();

  PlatformFile? selectedPdf;

  XFile? selectedImage;
  List<XFile>? detailsImgList = [];

  Future compressImageMain(XFile image) async {
    final compressedImage = await compressImageMb(image, 2);
    log("main image ${(await image.length()) / 1000000}");

    if(compressedImage != null){
      log("compressed  ${(await compressedImage.length()) / 1000000}");
      log("compressed image ${(await compressedImage.length()) / 1000000}");

      setState(() {
        selectedImage = compressedImage;
      });
    } else{
      // showToast('Please pick another image!');
    }
  }

  // Helper method to check if URL is YouTube
  bool _isYouTubeUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return YoutubePlayer.convertUrlToId(url) != null;
  }

  // Helper method to check if URL is a website
  bool _isWebsiteUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return !_isYouTubeUrl(url) && (url.startsWith('http://') || url.startsWith('https://'));
  }

  // Helper method to determine if file is an image
  bool _isImageFile(String fileName) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    final extension = fileName.toLowerCase().split('.').last;
    return imageExtensions.contains(extension);
  }

  // Helper method to determine if file is a PDF
  bool _isPdfFile(String fileName) {
    return fileName.toLowerCase().endsWith('.pdf');
  }

  // Helper method to get file type text
  String _getFileTypeText(String fileName) {
    if (_isImageFile(fileName)) {
      return "Image";
    } else if (_isPdfFile(fileName)) {
      return "PDF Document";
    } else {
      return "File";
    }
  }

  // Helper method to get file icon
  IconData _getFileIcon(String fileName) {
    if (_isImageFile(fileName)) {
      return Icons.image_outlined;
    } else if (_isPdfFile(fileName)) {
      return Icons.picture_as_pdf_outlined;
    } else {
      return Icons.attachment_outlined;
    }
  }

  // Helper method to get file color
  Color _getFileColor(String fileName) {
    if (_isImageFile(fileName)) {
      return Colors.green.shade600;
    } else if (_isPdfFile(fileName)) {
      return Colors.red.shade600;
    } else {
      return Colors.blue.shade600;
    }
  }

  // Clean description method
  String _cleanDescription(String htmlDescription) {
    return htmlDescription
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .trim();
  }

  // Format date method
  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateString;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final teacherController = StudentHomePageController.current;
      teacherController.getStudentContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (studentController) {
      return CustomScrollViewWidget(
        inAsyncCall: studentController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Lecture Sheet",
          expandedHeight: 60,
          centerTitle: widget.isBackIc == false ? true : false,
          isBackIc: widget.isBackIc,
        ),
        slivers: [
          sliverSizedBoxH(20),

          // Error state
          if (studentController.hasError && !studentController.isLoading)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red.shade300,
                      ),
                      sizedBoxH(16),
                      GlobalText(
                        str: "Failed to load lecture sheets",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorRes.deep400,
                        textAlign: TextAlign.center,
                      ),
                      sizedBoxH(8),
                      GlobalText(
                        str: "Please try again",
                        color: ColorRes.grey,
                        textAlign: TextAlign.center,
                      ),
                      sizedBoxH(16),
                      ElevatedButton.icon(
                        onPressed: () => studentController.getStudentContent(),
                        icon: Icon(Icons.refresh),
                        label: Text("Retry"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorRes.appColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Success state with data
          if (!studentController.isLoading && !studentController.hasError && studentController.studentContentModel != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: (studentController.studentContentModel?.contents?.isEmpty ?? true)
                  ? SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 64,
                          color: ColorRes.grey,
                        ),
                        sizedBoxH(16),
                        GlobalText(
                          str: "No lecture sheets found",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.deep400,
                          textAlign: TextAlign.center,
                        ),
                        sizedBoxH(8),
                        GlobalText(
                          str: "Add your first lecture sheet",
                          color: ColorRes.grey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  : SliverList.builder(
                itemCount: studentController.studentContentModel?.contents?.length ?? 0,
                itemBuilder: (context, index) {
                  final content = studentController.studentContentModel?.contents?[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: StudentLectureSheetWidget(
                      subject: content?.title ?? "No Title",
                      description: _cleanDescription(content?.description ?? ""),
                      imageUrl: studentController.studentContentModel?.systemSetting?.logo ?? "assets/dummy_img/book.jpg",
                      itemCount: index + 1,
                      hasFile: content?.contentFile?.isNotEmpty == true,
                      hasUrl: content?.url?.isNotEmpty == true,
                      onDownloadPressed: () {
                        if (content?.contentFile?.isNotEmpty == true) {
                          _downloadFile(content?.contentFile ?? "");
                        } else {
                          Get.snackbar(
                            "No File",
                            "No file available for download",
                            backgroundColor: Colors.orange.shade600,
                            colorText: Colors.white,
                          );
                        }
                      },
                      onTap: () {
                        _showLectureDetails(content);
                      },
                    ),
                  );
                },
              ),
            ),

          //sliverSizedBoxH(20),
        ],
      );
    });
  }

  void _downloadFile(String fileUrl) {
    // Direct download - opens in browser and starts download
    Get.snackbar(
      "Download",
      "Starting download...",
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      icon: Icon(Icons.download_outlined, color: Colors.white),
      duration: Duration(seconds: 2),
    );

    _launchUrl(fileUrl);
  }

  void _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          "Error",
          "Could not open link",
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not open link",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
  }

  void _showLectureDetails(Contents? contentData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: ColorRes.appColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.school_outlined,
                                color: ColorRes.appColor,
                                size: 28,
                              ),
                            ),
                            sizedBoxW(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GlobalText(
                                    str: contentData?.title ?? "No Title",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: ColorRes.deep400,
                                    maxLines: 3,
                                  ),
                                  sizedBoxH(4),
                                  GlobalText(
                                    str: "Created: ${_formatDate(contentData?.createdAt ?? "")}",
                                    color: ColorRes.grey,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        sizedBoxH(24),

                        // Show SuperVideoDetailsScreen only if YouTube URL
                        if (_isYouTubeUrl(contentData?.url))
                          SuperVideoDetailsScreen(
                            videoUrl: contentData?.url,
                          ),

                        // Description
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ColorRes.grey.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ColorRes.grey.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: "Description",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.deep400,
                              ),
                              sizedBoxH(8),
                              GlobalText(
                                str: _cleanDescription(contentData?.description ?? "No description available"),
                                color: ColorRes.deep100,
                                fontSize: 15,
                                maxLines: null,
                              ),
                            ],
                          ),
                        ),

                        // Content File section
                        if (contentData?.contentFile?.isNotEmpty == true) ...[
                          sizedBoxH(16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _getFileColor(contentData?.contentFile ?? "").withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _getFileColor(contentData?.contentFile ?? "").withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _getFileIcon(contentData?.contentFile ?? ""),
                                  color: _getFileColor(contentData?.contentFile ?? ""),
                                  size: 24,
                                ),
                                sizedBoxW(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GlobalText(
                                        str: _getFileTypeText(contentData?.contentFile ?? ""),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: _getFileColor(contentData?.contentFile ?? ""),
                                      ),
                                      sizedBoxH(2),
                                      GlobalText(
                                        str: contentData?.contentFile ?? "",
                                        fontSize: 14,
                                        color: ColorRes.deep400,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.download_outlined,
                                  color: _getFileColor(contentData?.contentFile ?? ""),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Website URL section (only show if not YouTube)
                        if (_isWebsiteUrl(contentData?.url)) ...[
                          sizedBoxH(16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.blue.shade100,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language_outlined,
                                  color: Colors.blue.shade600,
                                  size: 24,
                                ),
                                sizedBoxW(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GlobalText(
                                        str: "Website Link",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue.shade600,
                                      ),
                                      sizedBoxH(2),
                                      GlobalText(
                                        str: contentData?.url ?? "",
                                        fontSize: 14,
                                        color: ColorRes.deep400,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.open_in_new_outlined,
                                  color: Colors.blue.shade600,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],

                        sizedBoxH(20),

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.close, size: 18),
                                label: Text("Close"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: ColorRes.grey,
                                  side: BorderSide(color: ColorRes.grey.withValues(alpha: 0.3)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),

                            // Download button (only show for files)
                            if (contentData?.contentFile?.isNotEmpty == true) ...[
                              sizedBoxW(12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _downloadFile(contentData?.contentFile ?? "");
                                  },
                                  icon: Icon(Icons.download_outlined, size: 18),
                                  label: Text("Download"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade600,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],

                            // Open Website button (only show for website URLs, not YouTube)
                            if (_isWebsiteUrl(contentData?.url)) ...[
                              sizedBoxW(8),
                              ElevatedButton(
                                onPressed: () {
                                  _launchUrl(contentData?.url ?? "");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade600,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                ),
                                child: Icon(Icons.open_in_new, size: 18),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}