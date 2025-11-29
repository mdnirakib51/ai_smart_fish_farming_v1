
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../student_home_screen/model/student_notice_model.dart';
import 'widget/student_notification_item_widget.dart';

class StudentNotificationScreen extends StatefulWidget {
  const StudentNotificationScreen({super.key});

  @override
  State<StudentNotificationScreen> createState() => _StudentNotificationScreenState();
}

class _StudentNotificationScreenState extends State<StudentNotificationScreen> {

  @override
  void initState() {
    super.initState();
    final studentHomeController = StudentHomePageController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentsNotice();
    });
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _getTimeAgo(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      DateTime now = DateTime.now();
      Duration difference = now.difference(date);

      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown time';
    }
  }

  String _cleanDescription(String htmlDescription) {
    // Remove HTML tags and clean up the description
    return htmlDescription
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .trim();
  }

  IconData _getNotificationIcon(String title) {
    String lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('exam') || lowerTitle.contains('test') || lowerTitle.contains('পরীক্ষা')) {
      return Icons.school_outlined;
    } else if (lowerTitle.contains('death') || lowerTitle.contains('শোক') || lowerTitle.contains('মৃত্যু')) {
      return Icons.sentiment_very_dissatisfied_outlined;
    } else if (lowerTitle.contains('payment') || lowerTitle.contains('fee') || lowerTitle.contains('বেতন')) {
      return Icons.payment_outlined;
    } else if (lowerTitle.contains('admission') || lowerTitle.contains('ভর্তি')) {
      return Icons.how_to_reg_outlined;
    } else if (lowerTitle.contains('form') || lowerTitle.contains('ফরম')) {
      return Icons.description_outlined;
    } else {
      return Icons.notifications_outlined;
    }
  }

  Color _getNotificationColor(String title) {
    String lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('death') || lowerTitle.contains('শোক') || lowerTitle.contains('মৃত্যু')) {
      return Colors.red.shade400;
    } else if (lowerTitle.contains('exam') || lowerTitle.contains('test') || lowerTitle.contains('পরীক্ষা')) {
      return Colors.blue.shade400;
    } else if (lowerTitle.contains('payment') || lowerTitle.contains('fee') || lowerTitle.contains('বেতন')) {
      return Colors.green.shade400;
    } else if (lowerTitle.contains('form') || lowerTitle.contains('ফরম')) {
      return Colors.orange.shade400;
    } else {
      return ColorRes.appColor;
    }
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

  // Helper method to get file type icon
  IconData _getFileIcon(String fileName) {
    if (_isImageFile(fileName)) {
      return Icons.image_outlined;
    } else if (_isPdfFile(fileName)) {
      return Icons.picture_as_pdf_outlined;
    } else {
      return Icons.attachment_outlined;
    }
  }

  // Helper method to get file type color
  Color _getFileColor(String fileName) {
    if (_isImageFile(fileName)) {
      return Colors.green.shade600;
    } else if (_isPdfFile(fileName)) {
      return Colors.red.shade600;
    } else {
      return Colors.blue.shade600;
    }
  }

  // Helper method to get file type text
  String _getFileTypeText(String fileName) {
    if (_isImageFile(fileName)) {
      return "Image";
    } else if (_isPdfFile(fileName)) {
      return "PDF Document";
    } else {
      return "Attachment";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        inAsyncCall: homePageController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Notifications",
          expandedHeight: 60,
        ),
        slivers: [
          sliverSizedBoxH(20),

          // Error state
          if (homePageController.hasError && !homePageController.isLoading)
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
                        str: "Failed to load notifications",
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
                        onPressed: () => homePageController.getStudentsNotice(),
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
          if (!homePageController.isLoading && !homePageController.hasError && homePageController.studentNoticeModel != null)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: (homePageController.studentNoticeModel?.isEmpty ?? true) ? SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 64,
                          color: ColorRes.grey,
                        ),
                        sizedBoxH(16),
                        GlobalText(
                          str: "No notifications found",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorRes.deep400,
                          textAlign: TextAlign.center,
                        ),
                        sizedBoxH(8),
                        GlobalText(
                          str: "Check back later for new notifications",
                          color: ColorRes.grey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  : SliverList.builder(
                itemCount: homePageController.studentNoticeModel?.length,
                itemBuilder: (context, index) {
                  final notice = homePageController.studentNoticeModel?[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: StudentNotificationItemWidget(
                      title: notice?.title ?? "No Title",
                      subtitle: _cleanDescription(notice?.description ?? ""),
                      details: notice?.file?.isNotEmpty == true
                          ? "${_getFileTypeText(notice?.file ?? "")}: ${notice?.file}"
                          : null,
                      time: _getTimeAgo(notice?.createdAt ?? ""),
                      isRead: false,
                      icon: _getNotificationIcon(notice?.title ?? ""),
                      iconColor: _getNotificationColor(notice?.title ?? ""),
                      onTap: () {
                        _showNotificationDetails(notice);
                      },
                    ),
                  );
                },
              ),
            ),

          sliverSizedBoxH(20),
        ],
      );
    });
  }

  void _showNotificationDetails(StudentNoticeModel? noticeData) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: _getNotificationColor(noticeData?.title ?? "").withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                _getNotificationIcon(noticeData?.title ?? ""),
                                color: _getNotificationColor(noticeData?.title ?? ""),
                                size: 28,
                              ),
                            ),
                            sizedBoxW(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GlobalText(
                                    str: noticeData?.title ?? "No Title",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: ColorRes.deep400,
                                    maxLines: 3,
                                  ),
                                  sizedBoxH(4),
                                  GlobalText(
                                    str: _formatDate(noticeData?.createdAt ?? ""),
                                    color: ColorRes.grey,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        sizedBoxH(24),

                        // Content
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
                                str: "Details",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorRes.deep400,
                              ),
                              sizedBoxH(8),
                              GlobalText(
                                str: _cleanDescription(noticeData?.description ?? "No details available"),
                                color: ColorRes.deep100,
                                fontSize: 15,
                              ),
                            ],
                          ),
                        ),

                        // Attachment section
                        if (noticeData?.file?.isNotEmpty == true) ...[
                          sizedBoxH(16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _getFileColor(noticeData?.file ?? "").withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _getFileColor(noticeData?.file ?? "").withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _getFileIcon(noticeData?.file ?? ""),
                                  color: _getFileColor(noticeData?.file ?? ""),
                                  size: 24,
                                ),
                                sizedBoxW(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GlobalText(
                                        str: _getFileTypeText(noticeData?.file ?? ""),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: _getFileColor(noticeData?.file ?? ""),
                                      ),
                                      sizedBoxH(2),
                                      GlobalText(
                                        str: noticeData?.file ?? "",
                                        fontSize: 14,
                                        color: ColorRes.deep400,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                if (_isImageFile(noticeData?.file ?? ""))
                                  Icon(
                                    Icons.visibility_outlined,
                                    color: _getFileColor(noticeData?.file ?? ""),
                                    size: 20,
                                  )
                                else
                                  Icon(
                                    Icons.download_outlined,
                                    color: _getFileColor(noticeData?.file ?? ""),
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
                            if (noticeData?.file?.isNotEmpty == true) ...[
                              sizedBoxW(12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    _handleFileAction(noticeData?.file ?? "");
                                  },
                                  icon: Icon(
                                      _isImageFile(noticeData?.file ?? "")
                                          ? Icons.visibility_outlined
                                          : _isPdfFile(noticeData?.file ?? "")
                                          ? Icons.picture_as_pdf_outlined
                                          : Icons.download_outlined,
                                      size: 18
                                  ),
                                  label: Text(
                                      _isImageFile(noticeData?.file ?? "")
                                          ? "View Image"
                                          : _isPdfFile(noticeData?.file ?? "")
                                          ? "View PDF"
                                          : "Download"
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorRes.appColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                            // Add separate download button for PDF
                            if (_isPdfFile(noticeData?.file ?? "")) ...[
                              sizedBoxW(8),
                              ElevatedButton(
                                onPressed: () {
                                  _downloadFile(noticeData?.file ?? "");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                ),
                                child: Icon(Icons.download_outlined, size: 18),
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

  void _handleFileAction(String fileName) {
    if (_isImageFile(fileName)) {
      _viewImage(fileName);
    } else if (_isPdfFile(fileName)) {
      _viewPdf(fileName);
    } else {
      _downloadFile(fileName);
    }
  }

  void _viewImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (ctx, buildSetState){
            return Material(
              color: Colors.transparent,
              child: InteractiveViewer(
                child: Stack(
                  children: [
                    InteractiveViewer(
                      child: Center(
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, color: Colors.white, size: 48),
                              sizedBoxH(16),
                              GlobalText(
                                str: "Failed to load image",
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 20,
                      right: 20,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, size: 18),
                        label: GlobalText(str: "Close", color: ColorRes.grey),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorRes.grey,
                          side: BorderSide(color: ColorRes.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  void _viewPdf(String pdfUrl) {
    // Navigate to PDF viewer screen
    // You can use packages like flutter_pdfview, syncfusion_flutter_pdfviewer, or pdfx
    // For now, I'll show a placeholder implementation
    Get.snackbar(
      "PDF Viewer",
      "Opening PDF viewer...",
      backgroundColor: ColorRes.appColor,
      colorText: Colors.white,
    );

    // Example implementation with url_launcher (opens in browser)
    _launchUrl(pdfUrl);
  }

  void _downloadFile(String fileUrl) {
    // Implement file download logic
    // You can use packages like dio, http, or flutter_downloader
    Get.snackbar(
      "Download",
      "Starting download...",
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      icon: Icon(Icons.download_outlined, color: Colors.white),
    );

    // For web, you can use url_launcher to trigger download
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
          "Could not open file",
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not open file",
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../global/constants/colors_resources.dart';
// import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
// import '../../../global/widget/global_sized_box.dart';
// import '../../../global/widget/global_text.dart';
// import '../student_home_screen/controller/student_home_controller.dart';
// import '../student_home_screen/model/student_notice_model.dart';
// import 'widget/student_notification_item_widget.dart';
//
// class StudentNotificationScreen extends StatefulWidget {
//   const StudentNotificationScreen({super.key});
//
//   @override
//   State<StudentNotificationScreen> createState() => _StudentNotificationScreenState();
// }
//
// class _StudentNotificationScreenState extends State<StudentNotificationScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     final studentHomeController = StudentHomePageController.current;
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       studentHomeController.getStudentsNotice();
//     });
//   }
//
//   String _formatDate(String dateString) {
//     try {
//       DateTime date = DateTime.parse(dateString);
//       return DateFormat('dd MMM yyyy, hh:mm a').format(date);
//     } catch (e) {
//       return dateString;
//     }
//   }
//
//   String _getTimeAgo(String dateString) {
//     try {
//       DateTime date = DateTime.parse(dateString);
//       DateTime now = DateTime.now();
//       Duration difference = now.difference(date);
//
//       if (difference.inDays > 365) {
//         return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
//       } else if (difference.inDays > 30) {
//         return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
//       } else if (difference.inDays > 0) {
//         return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
//       } else if (difference.inHours > 0) {
//         return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
//       } else if (difference.inMinutes > 0) {
//         return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
//       } else {
//         return 'Just now';
//       }
//     } catch (e) {
//       return 'Unknown time';
//     }
//   }
//
//   String _cleanDescription(String htmlDescription) {
//     // Remove HTML tags and clean up the description
//     return htmlDescription
//         .replaceAll(RegExp(r'<[^>]*>'), '')
//         .replaceAll('&nbsp;', ' ')
//         .replaceAll('&amp;', '&')
//         .replaceAll('&lt;', '<')
//         .replaceAll('&gt;', '>')
//         .replaceAll('&quot;', '"')
//         .trim();
//   }
//
//   IconData _getNotificationIcon(String title) {
//     String lowerTitle = title.toLowerCase();
//     if (lowerTitle.contains('exam') || lowerTitle.contains('test') || lowerTitle.contains('পরীক্ষা')) {
//       return Icons.school_outlined;
//     } else if (lowerTitle.contains('death') || lowerTitle.contains('শোক') || lowerTitle.contains('মৃত্যু')) {
//       return Icons.sentiment_very_dissatisfied_outlined;
//     } else if (lowerTitle.contains('payment') || lowerTitle.contains('fee') || lowerTitle.contains('বেতন')) {
//       return Icons.payment_outlined;
//     } else if (lowerTitle.contains('admission') || lowerTitle.contains('ভর্তি')) {
//       return Icons.how_to_reg_outlined;
//     } else if (lowerTitle.contains('form') || lowerTitle.contains('ফরম')) {
//       return Icons.description_outlined;
//     } else {
//       return Icons.notifications_outlined;
//     }
//   }
//
//   Color _getNotificationColor(String title) {
//     String lowerTitle = title.toLowerCase();
//     if (lowerTitle.contains('death') || lowerTitle.contains('শোক') || lowerTitle.contains('মৃত্যু')) {
//       return Colors.red.shade400;
//     } else if (lowerTitle.contains('exam') || lowerTitle.contains('test') || lowerTitle.contains('পরীক্ষা')) {
//       return Colors.blue.shade400;
//     } else if (lowerTitle.contains('payment') || lowerTitle.contains('fee') || lowerTitle.contains('বেতন')) {
//       return Colors.green.shade400;
//     } else if (lowerTitle.contains('form') || lowerTitle.contains('ফরম')) {
//       return Colors.orange.shade400;
//     } else {
//       return ColorRes.appColor;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StudentHomePageController>(builder: (homePageController) {
//       return CustomScrollViewWidget(
//         sliverAppBar: SliverAppBarWidget(
//           titleText: "Notifications",
//           expandedHeight: 60,
//         ),
//         slivers: [
//           sliverSizedBoxH(20),
//
//           // Loading state
//           if (homePageController.isLoading)
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Center(
//                   child: Column(
//                     children: [
//                       CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(ColorRes.appColor),
//                       ),
//                       sizedBoxH(16),
//                       GlobalText(
//                         str: "Loading notifications...",
//                         color: ColorRes.grey,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//           // Error state
//           if (homePageController.hasError && !homePageController.isLoading)
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.error_outline,
//                         size: 64,
//                         color: Colors.red.shade300,
//                       ),
//                       sizedBoxH(16),
//                       GlobalText(
//                         str: "Failed to load notifications",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: ColorRes.deep400,
//                         textAlign: TextAlign.center,
//                       ),
//                       sizedBoxH(8),
//                       GlobalText(
//                         str: "Please try again",
//                         color: ColorRes.grey,
//                         textAlign: TextAlign.center,
//                       ),
//                       sizedBoxH(16),
//                       ElevatedButton.icon(
//                         onPressed: () => homePageController.getStudentsNotice(),
//                         icon: Icon(Icons.refresh),
//                         label: Text("Retry"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: ColorRes.appColor,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//           // Success state with data
//           if (!homePageController.isLoading && !homePageController.hasError && homePageController.studentNoticeModel != null)
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               sliver: (homePageController.studentNoticeModel?.isEmpty ?? true) ? SliverToBoxAdapter(
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(40),
//                     child: Column(
//                       children: [
//                         Icon(
//                           Icons.notifications_none_outlined,
//                           size: 64,
//                           color: ColorRes.grey,
//                         ),
//                         sizedBoxH(16),
//                         GlobalText(
//                           str: "No notifications found",
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: ColorRes.deep400,
//                           textAlign: TextAlign.center,
//                         ),
//                         sizedBoxH(8),
//                         GlobalText(
//                           str: "Check back later for new notifications",
//                           color: ColorRes.grey,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//                   : SliverList.builder(
//                 itemCount: homePageController.studentNoticeModel?.length,
//                 itemBuilder: (context, index) {
//                   final notice = homePageController.studentNoticeModel?[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: StudentNotificationItemWidget(
//                       title: notice?.title ?? "No Title",
//                       subtitle: _cleanDescription(notice?.description ?? ""),
//                       details: notice?.file?.isNotEmpty == true
//                           ? "Attachment: ${notice?.file}"
//                           : null,
//                       time: _getTimeAgo(notice?.createdAt ?? ""),
//                       isRead: false,
//                       icon: _getNotificationIcon(notice?.title ?? ""),
//                       iconColor: _getNotificationColor(notice?.title ?? ""),
//                       onTap: () {
//                         _showNotificationDetails(notice);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//           sliverSizedBoxH(20),
//         ],
//       );
//     });
//   }
//
//   void _showNotificationDetails(StudentNoticeModel? noticeData) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.6,
//         minChildSize: 0.3,
//         maxChildSize: 0.9,
//         builder: (context, scrollController) => Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: Column(
//             children: [
//               // Handle bar
//               Container(
//                 width: 40,
//                 height: 4,
//                 margin: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Header
//                         Row(
//                           children: [
//                             Container(
//                               width: 60,
//                               height: 60,
//                               decoration: BoxDecoration(
//                                 color: _getNotificationColor(noticeData?.title ?? "").withValues(alpha: 0.1),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Icon(
//                                 _getNotificationIcon(noticeData?.title ?? ""),
//                                 color: _getNotificationColor(noticeData?.title ?? ""),
//                                 size: 28,
//                               ),
//                             ),
//                             sizedBoxW(16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   GlobalText(
//                                     str: noticeData?.title ?? "No Title",
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w600,
//                                     color: ColorRes.deep400,
//                                     maxLines: 3,
//                                   ),
//                                   sizedBoxH(4),
//                                   GlobalText(
//                                     str: _formatDate(noticeData?.createdAt ?? ""),
//                                     color: ColorRes.grey,
//                                     fontSize: 12,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         sizedBoxH(24),
//
//                         // Content
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: ColorRes.grey.withValues(alpha: 0.05),
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: ColorRes.grey.withValues(alpha: 0.1),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               GlobalText(
//                                 str: "Details",
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600,
//                                 color: ColorRes.deep400,
//                               ),
//                               sizedBoxH(8),
//                               GlobalText(
//                                 str: _cleanDescription(noticeData?.description ?? "No details available"),
//                                 color: ColorRes.deep100,
//                                 fontSize: 15,
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // Attachment section
//                         if (noticeData?.file?.isNotEmpty == true) ...[
//                           sizedBoxH(16),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: Colors.blue.shade100,
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.attachment_outlined,
//                                   color: Colors.blue.shade600,
//                                   size: 20,
//                                 ),
//                                 sizedBoxW(8),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       GlobalText(
//                                         str: "Attachment",
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.blue.shade600,
//                                       ),
//                                       GlobalText(
//                                         str: noticeData?.file ?? "",
//                                         fontSize: 14,
//                                         color: ColorRes.deep400,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Icon(
//                                   Icons.download_outlined,
//                                   color: Colors.blue.shade600,
//                                   size: 20,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//
//                         sizedBoxH(20),
//
//                         // Action buttons
//                         Row(
//                           children: [
//                             Expanded(
//                               child: OutlinedButton.icon(
//                                 onPressed: () => Navigator.pop(context),
//                                 icon: Icon(Icons.close, size: 18),
//                                 label: Text("Close"),
//                                 style: OutlinedButton.styleFrom(
//                                   foregroundColor: ColorRes.grey,
//                                   side: BorderSide(color: ColorRes.grey.withValues(alpha: 0.3)),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(vertical: 12),
//                                 ),
//                               ),
//                             ),
//                             if (noticeData?.file?.isNotEmpty == true) ...[
//                               sizedBoxW(12),
//                               Expanded(
//                                 child: ElevatedButton.icon(
//                                   onPressed: () {
//                                     // Handle file download/view
//                                   },
//                                   icon: Icon(Icons.download_outlined, size: 18),
//                                   label: Text("Download"),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: ColorRes.appColor,
//                                     foregroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(vertical: 12),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }