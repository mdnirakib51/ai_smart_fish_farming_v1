import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class StudentLectureSheetWidget extends StatelessWidget {
  const StudentLectureSheetWidget({
    super.key,
    required this.subject,
    this.description,
    required this.imageUrl,
    this.color,
    this.itemCount,
    this.onDownloadPressed,
    this.onTap,
    this.hasFile = false,
    this.hasUrl = false,
  });

  final String subject;
  final String? description;
  final String imageUrl;
  final Color? color;
  final int? itemCount;
  final VoidCallback? onDownloadPressed;
  final VoidCallback? onTap;
  final bool hasFile;
  final bool hasUrl;

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

    return GestureDetector(
      onTap: onTap,
      child: StudentMenuTileContainer(
        color: color,
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
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Top gradient line
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withValues(alpha: 0.7)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Subject image/icon
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: imageUrl.startsWith('http')
                                    ? GlobalImageLoader(
                                  imagePath: imageUrl,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                )
                                    : Icon(
                                  Icons.school_outlined,
                                  color: color,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                          sizedBoxW(12),

                          // Content info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GlobalText(
                                  str: subject,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: ColorRes.deep400,
                                  maxLines: 2,
                                ),

                                if (description != null && description!.isNotEmpty) ...[
                                  sizedBoxH(6),
                                  GlobalText(
                                    str: description!,
                                    fontSize: 13,
                                    color: ColorRes.grey,
                                    maxLines: 2,
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Download button
                          GestureDetector(
                            onTap: onDownloadPressed,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.download_outlined,
                                color: hasFile ? color : Colors.grey.shade400,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Bottom info row
                      if (hasFile || hasUrl) ...[
                        sizedBoxH(12),
                        Row(
                          children: [
                            if (hasFile)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.attachment_outlined,
                                      size: 12,
                                      color: Colors.green.shade600,
                                    ),
                                    sizedBoxW(4),
                                    GlobalText(
                                      str: "File",
                                      fontSize: 11,
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            if (hasFile && hasUrl) sizedBoxW(8),
                            if (hasUrl)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_circle_outline,
                                      size: 12,
                                      color: Colors.red.shade600,
                                    ),
                                    sizedBoxW(4),
                                    GlobalText(
                                      str: "Video",
                                      fontSize: 11,
                                      color: Colors.red.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}