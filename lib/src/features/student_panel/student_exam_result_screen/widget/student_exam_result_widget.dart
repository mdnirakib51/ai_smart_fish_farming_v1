
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class ExamResultSummaryWidget extends StatelessWidget {
  const ExamResultSummaryWidget({
    super.key,
    required this.examName,
    required this.examDate,
    required this.resultStatus,
    this.color,
    this.itemCount,
    required this.onTap,
  });

  final String examName;
  final String examDate;
  final int resultStatus;
  final Color? color;
  final int? itemCount;
  final VoidCallback onTap;

  static const List<Color> _colorList = [
    ColorRes.blue,
    ColorRes.green,
    ColorRes.purple,
    ColorRes.red,
  ];

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Widget getStatusWidget() {
    switch (resultStatus) {
      case 1:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              sizedBoxW(6),
              GlobalText(
                str: "Published",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.green.shade700,
              ),
            ],
          ),
        );
      case 0:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              sizedBoxW(6),
              GlobalText(
                str: "Pending",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.orange.shade700,
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  shape: BoxShape.circle,
                ),
              ),
              sizedBoxW(6),
              GlobalText(
                str: "Unknown",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (itemCount != null ? _colorList[(itemCount! - 1) % _colorList.length] : ColorRes.appColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.quiz,
                    color: color,
                    size: 20,
                  ),
                ),
                sizedBoxW(12),
                Expanded(
                  child: GlobalText(
                    str: examName,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    maxLines: 2,
                  ),
                ),
              ],
            ),

            sizedBoxH(12),

            // Date and Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey.shade600,
                      size: 16,
                    ),
                    sizedBoxW(6),
                    GlobalText(
                      str: formatDate(examDate),
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                getStatusWidget(),
              ],
            ),

            sizedBoxH(16),

            // View Mark sheet Button
            resultStatus == 1 ? GestureDetector(
              onTap: resultStatus == 1 ? onTap : null,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: resultStatus == 1 ? color : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      resultStatus == 1 ? Icons.visibility_outlined : Icons.lock_outline,
                      color: resultStatus == 1 ? Colors.white : Colors.grey.shade600,
                      size: 18,
                    ),
                    sizedBoxW(8),
                    GlobalText(
                      str: resultStatus == 1 ? 'View Mark sheet' : 'Result Not Available',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: resultStatus == 1 ? Colors.white : Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}