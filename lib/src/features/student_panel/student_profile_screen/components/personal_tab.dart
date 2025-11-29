
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../student_home_screen/controller/student_home_controller.dart';
import 'student_profile_widget.dart';

class StudentPersonalTab extends StatelessWidget {
  final int selectedTab;

  const StudentPersonalTab({
    super.key,
    required this.selectedTab,
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
            topLeft: selectedTab == 0
                ? const Radius.circular(0)
                : const Radius.circular(8),
            topRight: const Radius.circular(8),
          ),
        ),
        child: Wrap(
          children: [
            StudentPersonalInfoWidget(
              label: 'Date of Birth',
              value: _formatBirthDate(student?.birthdate),
              icon: Icons.cake_outlined,
              itemColor: 1,
            ),
            StudentPersonalInfoWidget(
              label: 'Birth Registration No',
              value: student?.birthCertificateNo ?? 'N/A',
              icon: Icons.assignment_outlined,
              itemColor: 2,
            ),
            StudentPersonalInfoWidget(
              label: 'Blood Group',
              value: student?.bloodGroup ?? 'N/A',
              icon: Icons.bloodtype,
              itemColor: 3,
            ),
            StudentPersonalInfoWidget(
              label: 'Gender',
              value: student?.gender ?? 'N/A',
              icon: Icons.person_outline,
              itemColor: 4,
            ),
            StudentPersonalInfoWidget(
              label: 'Religion',
              value: student?.religion ?? 'N/A',
              icon: Icons.account_balance_outlined,
              itemColor: 5,
            ),
            StudentPersonalInfoWidget(
              label: 'Nationality',
              value: student?.nationality ?? 'N/A',
              icon: Icons.flag_outlined,
              itemColor: 6,
            ),
            StudentPersonalInfoWidget(
              label: 'Phone Number',
              value: _formatPhone(student?.phone),
              icon: Icons.phone_outlined,
              itemColor: 7,
            ),
            StudentPersonalInfoWidget(
              label: 'Email Address',
              value: student?.email ?? 'N/A',
              icon: Icons.email_outlined,
              itemColor: 8,
            ),
            StudentPersonalInfoWidget(
              label: 'Present Address',
              value: student?.address ?? 'N/A',
              icon: Icons.location_on_outlined,
              itemColor: 9,
            ),
            StudentPersonalInfoWidget(
              label: 'Permanent Address',
              value: student?.permanentAddress ?? 'N/A',
              icon: Icons.home_outlined,
              itemColor: 10,
            ),
            StudentPersonalInfoWidget(
              label: 'Unique ID',
              value: student?.uniqueId ?? 'N/A',
              icon: Icons.badge_outlined,
              itemColor: 11,
            ),
          ],
        ),
      );
    });
  }

  String _formatBirthDate(String? birthdate) {
    if (birthdate == null || birthdate.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(birthdate);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return birthdate;
    }
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