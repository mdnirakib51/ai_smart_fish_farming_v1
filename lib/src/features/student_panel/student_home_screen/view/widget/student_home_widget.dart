import 'package:flutter/material.dart';
import '../../../../../global/constants/colors_resources.dart';
import '../../../../../global/widget/global_image_loader.dart';
import '../../../../../global/widget/global_sized_box.dart';
import '../../../../../global/widget/global_text.dart';

class StudentHomeMenuWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final int? maxLines;
  final String imagePath;
  final String text;
  final Color color;

  const StudentHomeMenuWidget({
    super.key,
    this.height,
    this.width,
    this.maxLines,
    required this.imagePath,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Container with Gradient Background
                Container(
                  height: height ?? 50,
                  width: width ?? 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorRes.appColor.withValues(alpha: 0.10),
                        ColorRes.appColor.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ColorRes.appColor.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: GlobalImageLoader(
                      imagePath: imagePath,
                      height: (height ?? 50) * 0.7,
                      width: (width ?? 50) * 0.7,
                      fit: BoxFit.contain,
                      color: ColorRes.appColor,
                    ),
                  ),
                ),

                sizedBoxH(8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GlobalText(
                    str: text,
                    color: ColorRes.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: maxLines ?? 2,
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