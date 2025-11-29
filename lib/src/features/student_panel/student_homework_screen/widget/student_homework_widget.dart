import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_couple_text_button.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class StudentHomeworkWidget extends StatefulWidget {
  const StudentHomeworkWidget({
    super.key,
    required this.subject,
    required this.code,
    required this.status,
    required this.homeworkDate,
    required this.submissionDate,
    required this.createdBy,
    required this.marks,
    required this.topic,
    required this.description,
    required this.note,
    this.color,
    this.itemCount,
    this.uploadedFileName,
    this.isSubmitted = false,
    required this.onUploadDocument,
    required this.onSubmit,
    this.onFileSelected, // Added callback for file selection
  });

  final String subject;
  final String code;
  final String status;
  final String homeworkDate;
  final String submissionDate;
  final String createdBy;
  final String marks;
  final String topic;
  final String description;
  final String note;
  final Color? color;
  final int? itemCount;
  final String? uploadedFileName;
  final bool isSubmitted;
  final VoidCallback onUploadDocument;
  final VoidCallback onSubmit;
  final Function(PlatformFile?)? onFileSelected; // New callback

  static const List<Color> colorList = [
    ColorRes.blue,
    ColorRes.green,
    ColorRes.purple,
    ColorRes.red,
    ColorRes.indigo,
    ColorRes.orange,
    ColorRes.brown,
    ColorRes.greyBlue,
    ColorRes.darkGreen,
  ];

  @override
  State<StudentHomeworkWidget> createState() => _StudentHomeworkWidgetState();
}

class _StudentHomeworkWidgetState extends State<StudentHomeworkWidget> {
  PlatformFile? selectedPdf;
  bool isUploading = false;

  Future<void> _pickDocument() async {
    try {
      setState(() {
        isUploading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        final pickedFile = result.files.single;

        // Check file size (limit to 10MB)
        if (pickedFile.size > 10 * 1024 * 1024) {
          _showSnackBar('File size should be less than 10MB', Colors.red);
          return;
        }

        setState(() {
          selectedPdf = pickedFile;
        });

        // Call the callback to notify parent widget
        if (widget.onFileSelected != null) {
          widget.onFileSelected!(pickedFile);
        }

        log("Selected File Name: ${pickedFile.name}");
        log("Selected File Path: ${pickedFile.path}");
        log("Selected File Size: ${(pickedFile.size / 1024).toStringAsFixed(2)} KB");

        _showSnackBar('File "${pickedFile.name}" selected successfully!', Colors.green);

        // Call the original callback
        widget.onUploadDocument();

      } else {
        log("User canceled the file picker");
      }
    } catch (e) {
      log("Error picking file: $e");
      _showSnackBar('Error selecting file: $e', Colors.red);
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _removeSelectedFile() {
    setState(() {
      selectedPdf = null;
    });
    if (widget.onFileSelected != null) {
      widget.onFileSelected!(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = widget.color ??
        (widget.itemCount != null
            ? StudentHomeworkWidget.colorList[(widget.itemCount! - 1) % StudentHomeworkWidget.colorList.length]
            : ColorRes.appColor);

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 18,
                        color: selectedColor.withValues(alpha: 0.8),
                      ),
                      sizedBoxW(10),
                      GlobalText(
                        str: widget.subject,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ColorRes.black,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.status == 'Submitted'
                        ? Colors.green.withValues(alpha: 0.2)
                        : widget.status == 'Overdue'
                        ? Colors.red.withValues(alpha: 0.2)
                        : Colors.orange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GlobalText(
                    str: widget.status,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: widget.status == 'Submitted'
                        ? Colors.green
                        : widget.status == 'Overdue'
                        ? Colors.red
                        : Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // Details Section
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailRow(
                        icon: Icons.calendar_today_outlined,
                        label: "Homework Date:",
                        value: widget.homeworkDate,
                        color: Colors.blue,
                      ),
                    ),
                    sizedBoxW(12),
                    Expanded(
                      child: _buildDetailRow(
                        icon: Icons.schedule_outlined,
                        label: "Submission Date:",
                        value: widget.submissionDate,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                sizedBoxH(10),
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailRow(
                        icon: Icons.person_outline,
                        label: "Created By:",
                        value: widget.createdBy,
                        color: Colors.green,
                      ),
                    ),
                    sizedBoxW(12),
                    Expanded(
                      child: _buildDetailRow(
                        icon: Icons.star_outline,
                        label: "Marks:",
                        value: widget.marks,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),

                sizedBoxH(10),
                _buildDetailRow(
                  icon: Icons.topic_outlined,
                  label: "Topic:",
                  value: widget.topic,
                  color: Colors.indigo,
                ),
                sizedBoxH(10),
                GlobalText(
                  str: widget.description,
                  fontSize: 12,
                  color: ColorRes.deep400,
                ),
              ],
            ),
          ),

          // Selected File Display
          if (selectedPdf != null || widget.uploadedFileName != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_file,
                    color: Colors.blue.shade600,
                    size: 20,
                  ),
                  sizedBoxW(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: selectedPdf?.name ?? widget.uploadedFileName ?? '',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                        if (selectedPdf != null)
                          GlobalText(
                            str: '${(selectedPdf!.size / 1024).toStringAsFixed(2)} KB',
                            fontSize: 10,
                            color: Colors.blue.shade600,
                          ),
                      ],
                    ),
                  ),
                  if (!widget.isSubmitted)
                    IconButton(
                      onPressed: _removeSelectedFile,
                      icon: Icon(
                        Icons.close,
                        color: Colors.red.shade600,
                        size: 18,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ),

          // Note Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: GlobalText(
              str: widget.note,
              fontSize: 10,
              fontStyle: FontStyle.italic,
              color: ColorRes.grey,
              textAlign: TextAlign.center,
            ),
          ),

          sizedBoxH(5),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GlobalButtonWidget(
                    str: isUploading
                        ? 'Uploading...'
                        : selectedPdf != null || widget.uploadedFileName != null
                        ? 'Change Document'
                        : 'Upload Document',
                    height: 45,
                    img: isUploading ? null : Images.uploadIc,
                    imgColor: ColorRes.grey,
                    borderColor: ColorRes.grey,
                    textColor: isUploading ? Colors.white : ColorRes.appColor,
                    buttomColor: isUploading ? ColorRes.appColor : ColorRes.white,
                    onTap: isUploading ? null : _pickDocument,
                  ),
                ),
                sizedBoxW(12),
                Expanded(
                  child: GlobalButtonWidget(
                    str: widget.isSubmitted ? 'Submitted' : 'Submit',
                    height: 48,
                    radius: 12,
                    buttomColor: widget.isSubmitted
                        ? ColorRes.appColor
                        : (selectedPdf != null || widget.uploadedFileName != null)
                        ? ColorRes.appColor
                        : Colors.grey.shade400,
                    textColor: Colors.white,
                    onTap: widget.isSubmitted
                        ? null
                        : (selectedPdf != null || widget.uploadedFileName != null)
                        ? widget.onSubmit
                        : null,
                  ),
                ),
              ],
            ),
          ),
          sizedBoxH(5)
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isDescription = false,
  }) {
    return Row(
      crossAxisAlignment: isDescription ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        sizedBoxW(8),
        Expanded(
          child: CoupleTextButton(
            firstText: label,
            secondText: value,
          ),
        ),
      ],
    );
  }
}