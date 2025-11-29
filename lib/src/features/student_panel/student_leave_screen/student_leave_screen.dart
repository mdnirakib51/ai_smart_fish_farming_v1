import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'student_apply_leave_screen.dart';
import 'widget/student_approved_tab.dart';
import 'widget/student_cancelled_tab.dart';
import 'widget/student_panding_tab.dart';

class StudentLeaveScreen extends StatefulWidget {
  const StudentLeaveScreen({super.key});

  @override
  State<StudentLeaveScreen> createState() => _StudentLeaveScreenState();
}

class _StudentLeaveScreenState extends State<StudentLeaveScreen> {


  int selectedTab = 0;
  final tabDataList = ["Pending", "Approved", "Cancelled"];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Leave List",
          expandedHeight: 60,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(() => StudentApplyLeaveScreen());
              },
              child: const GlobalImageLoader(
                imagePath: Images.plusIc,
                height: 22,
                width: 22,
                color: ColorRes.white,
                fit: BoxFit.fill,
              ),
            ),
            sizedBoxW(20),
          ],
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
                  Row(
                    children: tabDataList.asMap().entries.map((item){
                      return Expanded(
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedTab = item.key;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5)
                              ),
                              color: selectedTab == item.key ? ColorRes.appColor : Colors.transparent,
                              border: Border.all(
                                color: ColorRes.appColor.withValues(alpha:0.1),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: GlobalText(
                                str: item.value,
                                color: selectedTab != item.key ? ColorRes.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  sizedBoxH(10),
                  IndexedStack(
                    index: selectedTab,
                    children: [
                      PendingTab(selectedTab: selectedTab),
                      ApprovedTab(),
                      CancelledTab(),
                    ],
                  ),

                ],
              ),
            ),
          ),
          sliverSizedBoxH(80),
        ],
      );
    });
  }
}