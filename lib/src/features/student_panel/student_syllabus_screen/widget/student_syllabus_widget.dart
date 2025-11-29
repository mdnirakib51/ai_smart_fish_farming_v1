import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class StudentSyllabusWidget extends StatelessWidget {
  const StudentSyllabusWidget({
    super.key,
    required this.subject,
    this.description,
    required this.imageUrl,
    this.color,
    this.itemCount,
    this.onDownloadPressed,
    this.onTap,
  });
  final String subject;
  final String? description;
  final String imageUrl;
  final Color? color;
  final int? itemCount;
  final VoidCallback? onDownloadPressed;
  final VoidCallback? onTap;

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
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [ color, color.withValues(alpha:0.7)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: GlobalImageLoader(
                                imagePath: imageUrl,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          sizedBoxW(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GlobalText(
                                  str: subject,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorRes.deep400,
                                ),

                                if (description != null && description!.isNotEmpty) ...[
                                  sizedBoxH(4),
                                  GlobalText(
                                    str: description!,
                                    fontSize: 12,
                                    color: ColorRes.grey,
                                    maxLines: 2,
                                  ),
                                ],
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: onDownloadPressed,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.cloud_download_rounded,
                                color: Colors.grey.shade600,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
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