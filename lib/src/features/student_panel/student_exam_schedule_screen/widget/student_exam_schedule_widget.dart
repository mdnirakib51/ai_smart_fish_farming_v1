import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class StudentExamScheduleWidget extends StatelessWidget {
  const StudentExamScheduleWidget({
    super.key,
    required this.subject,
    this.examTime,
    this.examDate,
    this.totalMark,
    this.passMark,
    this.color,
    this.itemCount,
  });
  final String subject;
  final String? examTime;
  final String? examDate;
  final String? totalMark;
  final String? passMark;
  final Color? color;
  final int? itemCount;

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
  Widget build(BuildContext context) {
    final color = this.color ?? (itemCount != null ? colorList[(itemCount! - 1) % colorList.length] : ColorRes.appColor);

    return StudentMenuTileContainer(
      color: color,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        str: subject,
                        fontSize: 16,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                      GlobalText(
                        str: examTime ?? '',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.deep100,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlobalText(
                      str: examDate ?? '',
                      fontSize: 14,
                      color: ColorRes.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GlobalText(
                            str: 'Total Mark:',
                            fontSize: 14,
                            color: ColorRes.deep400,
                            fontWeight: FontWeight.bold,
                          ),
                          sizedBoxW(5),
                          GlobalText(
                            str: totalMark ?? '',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GlobalText(
                      str: 'Pass Mark:',
                      fontSize: 14,
                      color: ColorRes.deep400,
                      fontWeight: FontWeight.bold,
                    ),
                    sizedBoxW(5),
                    GlobalText(
                      str: passMark ?? '',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}