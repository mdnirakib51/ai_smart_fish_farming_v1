
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class StudentDriverProfileDetailWidget extends StatelessWidget {
  const StudentDriverProfileDetailWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.color,
    this.itemCount,
  });
  final String label;
  final String? value;
  final IconData? icon;
  final Color? color;
  final int? itemCount;

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

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (itemCount != null ? _colorList[(itemCount! - 1) % _colorList.length] : ColorRes.appColor);

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              sizedBoxW(16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    str: label,
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  sizedBoxH(4),
                  GlobalText(
                    str: value ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2d3748),
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

class DriverInfoWidget extends StatelessWidget {
  const DriverInfoWidget({
    super.key,
    required this.name,
    this.designation,
    this.busNumber,
    this.startingTime,
    this.arrivingTime,
    this.color,
    this.itemCount,
    required this.onTap,
  });
  final String name;
  final String? designation;
  final String? busNumber;
  final String? startingTime;
  final String? arrivingTime;
  final Color? color;
  final int? itemCount;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: ColorRes.appColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: GlobalImageLoader(
                      imagePath: Images.studentProfile,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        str: name,
                        color: ColorRes.appColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      GlobalText(
                        str: designation ?? ' ',
                        color: ColorRes.deep100,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.phone, color: ColorRes.appColor),
                  onPressed: () {},
                ),
                Icon(Icons.chevron_right, color: ColorRes.deep100),
              ],
            ),
            sizedBoxH(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalText(
                  str: "Bus number",
                  color: ColorRes.deep100,
                ),
                GlobalText(
                  str: busNumber ?? ' ',
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            sizedBoxH(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalText(
                  str: "Starting time",
                  color: ColorRes.deep100,
                ),
                GlobalText(
                  str: startingTime ?? ' ',
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            sizedBoxH(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalText(
                  str: "Arriving time",
                  color: ColorRes.deep100,
                ),
                GlobalText(
                  str: arrivingTime ?? ' ',
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}