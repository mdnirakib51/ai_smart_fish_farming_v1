
import 'package:flutter/material.dart';
import 'package:ai_smart_fish_farming/src/global/constants/images.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class StudentTeacherListInfoWidget extends StatelessWidget {
  const StudentTeacherListInfoWidget({
    super.key,
    required this.photo,
    required this.name,
    required this.designation,
    required this.phone,
    required this.email,
    required this.subject,
    this.color,
    this.itemCount,
  });

  final String photo;
  final String name;
  final String designation;
  final String phone;
  final String email;
  final String subject;
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
          decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ColorRes.appColor.withValues(alpha:0.1),
              width: .5,
            ),
          boxShadow: [
            BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
            ),
          ],
        ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorRes.appColor.withValues(alpha:0.03),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  // Profile image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorRes.appColor.withValues(alpha:0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: GlobalImageLoader(
                        imagePath: photo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  sizedBoxW(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        GlobalText(
                          str: name,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ColorRes.deep400,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ColorRes.appColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GlobalText(
                            str: designation,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.appColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              size: 16,
                              color: ColorRes.grey,
                            ),
                            sizedBoxW(4),
                            GlobalText(
                              str: subject,
                              fontSize: 14,
                              color: ColorRes.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Contact info section
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: ColorRes.appColor.withValues(alpha:0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.phone_rounded,
                                size: 22,
                                color: ColorRes.appColor,
                              ),
                            ),
                            sizedBoxW(10),
                            Expanded(
                              child: GlobalText(
                                str: phone,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH(5),
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: ColorRes.appColor.withValues(alpha:0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.email_rounded,
                                size: 22,
                                color: ColorRes.appColor,
                              ),
                            ),
                            sizedBoxW(10),
                            Expanded(
                              child: GlobalText(
                                str: email,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  sizedBoxW(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GlobalImageLoader(
                          imagePath: Images.facebookIc,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                        sizedBoxH(5),
                        GlobalImageLoader(
                          imagePath: Images.linkedInIc,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 5,
              ),
              child: GlobalButtonWidget(
                str: 'Contact Teacher',
                textColor: ColorRes.appColor,
                borderColor: ColorRes.appColor.withValues(alpha: 0.4),
                buttomColor: ColorRes.white,
                height: 40,
                radius: 10,
                onTap: () {

                },
              ),
            ),
          ],
        ),
      ),
        ),
    );
  }
}