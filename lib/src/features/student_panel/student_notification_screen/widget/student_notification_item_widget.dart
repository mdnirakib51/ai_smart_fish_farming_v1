
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class StudentNotificationItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? details;
  final String time;
  final bool isRead;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const StudentNotificationItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.details,
    required this.time,
    this.isRead = false,
    this.icon = Icons.notifications_outlined,
    this.iconColor = Colors.blue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
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
          border: Border.all(
            color: isRead ? Colors.transparent : iconColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Stack(
          children: [
            // Unread indicator
            // if (!isRead)
            //   Positioned(
            //     top: 12,
            //     right: 12,
            //     child: Container(
            //       width: 8,
            //       height: 8,
            //       decoration: BoxDecoration(
            //         color: iconColor,
            //         shape: BoxShape.circle,
            //       ),
            //     ),
            //   ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon container
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 24,
                    ),
                  ),

                  sizedBoxW(12),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        GlobalText(
                          str: title,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.deep400,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        sizedBoxH(4),

                        // Subtitle
                        GlobalText(
                          str: subtitle,
                          color: ColorRes.deep100,
                          fontSize: 14,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        sizedBoxH(8),

                        // Time and details row
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              size: 14,
                              color: ColorRes.grey,
                            ),
                            sizedBoxW(4),
                            GlobalText(
                              str: time,
                              fontSize: 12,
                              color: ColorRes.grey,
                            ),

                            // Attachment indicator
                            if (details?.contains('Attachment') == true) ...[
                              sizedBoxW(12),
                              Icon(
                                Icons.attach_file_outlined,
                                size: 14,
                                color: ColorRes.grey,
                              ),
                              sizedBoxW(2),
                              GlobalText(
                                str: "File",
                                fontSize: 11,
                                color: ColorRes.grey,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Arrow indicator
                  Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: ColorRes.grey.withValues(alpha: 0.7),
                    size: 20,
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