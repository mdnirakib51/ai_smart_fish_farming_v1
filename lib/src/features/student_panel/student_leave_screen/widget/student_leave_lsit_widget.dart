import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class LeaveListWidget extends StatelessWidget {
  const LeaveListWidget({
    super.key,
    required this.leaveReason,
    this.fromDate,
    this.toDate,
    this.day,
    this.status,
    this.color,
    this.statusColor,
  });

  final String leaveReason;
  final String? fromDate;
  final String? toDate;
  final String? day;
  final String? status;
  final Color? color;
  final int? statusColor;

  static const List<Color> _colorList = [
    ColorRes.red,
    ColorRes.green,
    ColorRes.grey,
  ];

  // Status icon mapping
  IconData _getStatusIcon() {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Icons.check_circle_outline;
      case 'pending':
        return Icons.schedule_outlined;
      case 'rejected':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (statusColor != null ? _colorList[(statusColor! - 1) % _colorList.length] : ColorRes.appColor);

    return StudentMenuTileContainer(
      color: color,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border.all(
                  color: Colors.grey.shade100,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // From date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GlobalText(
                              str: 'From: ',
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                            sizedBoxW(4),
                            GlobalText(
                              str: fromDate ?? '',
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  // Divider
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),

                  // To date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GlobalText(
                              str: 'To',
                              fontSize: 12,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                            sizedBoxW(4),
                            GlobalText(
                              str: toDate ?? '',
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Main content
            Padding(
              padding: const EdgeInsets.all(10),
              child: GlobalText(
                str: leaveReason,
                fontSize: 14,
                maxLines: 3,
                textAlign: TextAlign.start,
              ),
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  if (day != null) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        GlobalText(
                          str: '$day Day${(day != null && day != "1") ? "s" : ""}',
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                  const Spacer(),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusIcon(),
                        size: 16,
                        color: color,
                      ),
                      const SizedBox(width: 6),
                      GlobalText(
                        str: status?.toUpperCase() ?? '',
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}