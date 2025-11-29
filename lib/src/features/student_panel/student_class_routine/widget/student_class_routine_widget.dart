import 'package:flutter/material.dart';
import 'package:ai_smart_fish_farming/src/global/constants/enum.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class StudentClassRoutineWidget extends StatelessWidget {
  const StudentClassRoutineWidget({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.teacher,
    this.color,
    this.itemCount,
    required this.imageUrl,
    this.periodName,
    this.isSubjectAssigned = true,
  });

  final String startTime;
  final String endTime;
  final String subject;
  final String teacher;
  final Color? color;
  final int? itemCount;
  final String imageUrl;
  final String? periodName;
  final bool isSubjectAssigned;

  static const List<Color> _colorList = [
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

  // Helper method to format time (remove AM/PM if present and reformat)
  String formatTime(String time) {
    if (time.isEmpty) return '';

    // Remove extra spaces and standardize format
    final cleanTime = time.trim().replaceAll(RegExp(r'\s+'), ' ');

    // If it already has AM/PM, return as is
    if (cleanTime.toUpperCase().contains('AM') || cleanTime.toUpperCase().contains('PM')) {
      return cleanTime;
    }

    return cleanTime;
  }

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (itemCount != null ? _colorList[(itemCount! - 1) % _colorList.length] : ColorRes.appColor);

    // Use grey color scheme for unassigned subjects
    final displayColor = isSubjectAssigned ? color : Colors.grey;
    final backgroundColor = isSubjectAssigned ? Colors.white : Colors.grey.shade50;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: isSubjectAssigned ? null : Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isSubjectAssigned ? 0.05 : 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Time column
          sizedBoxW(6),
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: displayColor.withValues(alpha: isSubjectAssigned ? 0.1 : 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GlobalText(
                  str: formatTime(startTime),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: displayColor,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  height: 1,
                  color: displayColor.withValues(alpha: 0.3),
                ),
                GlobalText(
                  str: formatTime(endTime),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: displayColor,
                ),
              ],
            ),
          ),

          // Timeline indicator
          Container(
            width: 20,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: displayColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: isSubjectAssigned ? [
                      BoxShadow(
                        color: displayColor.withValues(alpha: 0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ] : null,
                  ),
                ),
                Container(
                  width: 2,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isSubjectAssigned ? [
                        displayColor,
                        displayColor.withValues(alpha: 0.3),
                      ] : [
                        displayColor.withValues(alpha: 0.5),
                        displayColor.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // Subject icon/avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: isSubjectAssigned ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          displayColor.withValues(alpha: 0.8),
                          displayColor,
                        ],
                      ) : null,
                      color: isSubjectAssigned ? null : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSubjectAssigned ? [
                        BoxShadow(
                          color: displayColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: isSubjectAssigned ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GlobalImageLoader(
                        imagePath: imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        imageFor: ImageFor.network,
                      ),
                    ) : Icon(
                      Icons.schedule_outlined,
                      color: Colors.grey.shade500,
                      size: 24,
                    ),
                  ),

                  sizedBoxW(12),

                  // Subject details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subject name
                        GlobalText(
                          str: subject,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSubjectAssigned ? Colors.grey.shade800 : Colors.grey.shade500,
                        ),

                        sizedBoxH(4),

                        // Period name
                        if (periodName != null && periodName!.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: displayColor.withValues(alpha: isSubjectAssigned ? 0.1 : 0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GlobalText(
                              str: periodName!,
                              fontSize: 10,
                              color: displayColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          sizedBoxH(4),
                        ],

                        // Teacher name or message
                        Row(
                          children: [
                            Icon(
                              isSubjectAssigned ? Icons.person_outline : Icons.info_outline,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            sizedBoxW(4),
                            Expanded(
                              child: GlobalText(
                                str: teacher,
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontStyle: isSubjectAssigned ? FontStyle.normal : FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Action button (optional)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: displayColor.withValues(alpha: isSubjectAssigned ? 0.1 : 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isSubjectAssigned ? Icons.arrow_forward_ios : Icons.help_outline,
                      size: 14,
                      color: displayColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}