
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import 'widget/student_driver_profile_detail_widget.dart';

class StudentDriverProfileScreen extends StatelessWidget {
  const StudentDriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Bus Driver",
          flexibleSpace: StudentFlexibleSpaceBackWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha:0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: ColorRes.white,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: GlobalImageLoader(
                            imagePath: Images.studentProfile,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      sizedBoxW(15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              str: 'Mohammad Ali',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            Row(
                              children: [
                                GlobalText(str: 'Bus Number:', color: Colors.white70, fontWeight: FontWeight.w700),
                                sizedBoxW(2),
                                GlobalText(str: '134 - Line 3', color: Colors.white70),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        slivers: [
          sliverSizedBoxH(10),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBoxH(10),
                  StudentDriverProfileDetailWidget(
                    label: 'Experience',
                    value: '5 years',
                    icon: Icons.work_outline,
                    itemCount: 1,
                  ),
                  StudentDriverProfileDetailWidget(
                    label: 'Blood Group',
                    value: 'B +ve',
                    icon: Icons.bloodtype_outlined,
                    itemCount: 2,
                  ),
                  StudentDriverProfileDetailWidget(
                    label: 'Phone Number',
                    value: '01865 781340',
                    icon: Icons.phone_outlined,
                    itemCount: 3,
                  ),
                  StudentDriverProfileDetailWidget(
                    label: 'Address',
                    value: 'Level-2, 25/2 Lake Circus Road, Kalabagan, Dhanmondi, Dhaka.',
                    icon: Icons.location_on_outlined,
                    itemCount: 4,
                  ),
                ],
              ),
            ),
          ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }
}

