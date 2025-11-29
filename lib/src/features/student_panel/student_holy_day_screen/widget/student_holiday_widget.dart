
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class StudentHolidayWidget extends StatelessWidget {
  const StudentHolidayWidget({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    this.color,
    required this.itemCount,
  });

  final String title;
  final String description;
  final String date;
  final Color? color;
  final int itemCount;

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

  // Helper method to format date if needed
  String _formatDate(String dateStr) {
    try {
      if (dateStr.contains('/')) {
        final parts = dateStr.split('/');
        if (parts.length == 3) {
          return "${parts[0]} ${_getMonthName(int.parse(parts[1]))} ${parts[2]}";
        }
      }
    } catch (e) {
      // Return original if parsing fails
    }
    return dateStr;
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return month >= 1 && month <= 12 ? months[month] : '';
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = this.color ?? colorList[(itemCount - 1) % colorList.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          // Main card container
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: selectedColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and date row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            str: title,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: ColorRes.black,
                          ),
                          sizedBoxH(4),
                          Container(
                            height: 3,
                            width: 40,
                            decoration: BoxDecoration(
                              color: selectedColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxW(16),
                    // Date chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: selectedColor,
                          ),
                          const SizedBox(width: 6),
                          GlobalText(
                            str: _formatDate(date),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selectedColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                sizedBoxH(16),

                // Description
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: ColorRes.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ColorRes.grey.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: selectedColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GlobalText(
                          str: description,
                          fontSize: 14,
                          color: ColorRes.deep400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                sizedBoxH(12),

                // Holiday indicator
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.celebration,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          GlobalText(
                            str: "Holiday",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Left colored accent bar
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}