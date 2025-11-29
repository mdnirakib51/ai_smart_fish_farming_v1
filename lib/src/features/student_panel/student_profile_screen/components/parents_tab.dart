import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';
import '../../student_home_screen/controller/student_home_controller.dart';

class StudentParentsTab extends StatelessWidget {
  const StudentParentsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (controller) {
      final student = controller.studentProfileModel?.student;
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            ParentInfoWidget(
              type: "Father",
              name: student?.fatherName ?? 'N/A',
              phone: _formatPhone(student?.fPhone),
              address: student?.address ?? 'N/A',
              occupation: student?.fatherOccupation ?? 'N/A',
              nid: student?.fatherNid ?? 'N/A',
              icon: Icons.man,
              itemColor: 1,
            ),
            ParentInfoWidget(
              type: "Mother",
              name: student?.motherName ?? 'N/A',
              phone: _formatPhone(student?.mPhone),
              address: student?.address ?? 'N/A',
              occupation: student?.motherOccupation ?? 'N/A',
              nid: student?.motherNid ?? 'N/A',
              icon: Icons.woman,
              itemColor: 2,
            ),
            ParentInfoWidget(
              type: "Guardian",
              name: student?.gName ?? 'N/A',
              phone: _formatPhone(student?.gPhone),
              address: student?.address ?? 'N/A',
              occupation: 'N/A', // Guardian occupation not in API
              nid: 'N/A', // Guardian NID not in API
              icon: Icons.shield_outlined,
              itemColor: 3,
            ),
          ],
        ),
      );
    });
  }

  String _formatPhone(String? phone) {
    if (phone == null || phone.isEmpty) return 'N/A';
    // Format phone number with +88 prefix if not present
    if (phone.startsWith('01')) {
      return '+88 $phone';
    }
    return phone;
  }
}


class ParentInfoWidget extends StatelessWidget {
  const ParentInfoWidget({
    super.key,
    required this.type,
    required this.name,
    required this.phone,
    required this.address,
    required this.icon,
    required this.occupation,
    required this.nid,
    this.color,
    this.itemColor,
    this.itemCount,
  });

  final String type;
  final String name;
  final String phone;
  final String address;
  final String occupation;
  final String nid;
  final IconData icon;
  final Color? color;
  final int? itemColor;
  final int? itemCount;

  static const List<Color> colorList = [
    ColorRes.blue,
    ColorRes.pink,
    ColorRes.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (itemColor != null ? colorList[(itemColor! - 1) % colorList.length] : ColorRes.appColor);

    return StudentMenuTileContainer(
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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 80,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    sizedBoxH(10),
                    GlobalText(
                      str: type,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      GlobalText(
                        str: name,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: ColorRes.deep400,
                      ),
                      sizedBoxH(8),

                      // Phone
                      _buildInfoRow(
                        Icons.phone_outlined,
                        phone,
                        ColorRes.green,
                      ),
                      sizedBoxH(6),

                      // Occupation
                      _buildInfoRow(
                        Icons.work_outline,
                        occupation,
                        ColorRes.blue,
                      ),
                      sizedBoxH(6),

                      // NID
                      if (nid != 'N/A' && nid.isNotEmpty) ...[
                        _buildInfoRow(
                          Icons.card_membership_outlined,
                          nid,
                          ColorRes.purple,
                        ),
                        sizedBoxH(6),
                      ],

                      // Address
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        address,
                        ColorRes.orange,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon,
      String text,
      Color iconColor, {
        int maxLines = 1,
      }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 14,
            color: iconColor,
          ),
        ),
        sizedBoxW(10),
        Flexible(
          child: GlobalText(
            str: text,
            color: ColorRes.deep400,
            fontWeight: FontWeight.w500,
            maxLines: maxLines,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
