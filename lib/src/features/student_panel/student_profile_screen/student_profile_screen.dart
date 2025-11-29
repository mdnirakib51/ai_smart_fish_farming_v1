
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_smart_fish_farming/src/global/constants/enum.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import '../../widget/student_menu_background_container.dart';
import '../student_drawer/view/student_drawer_screen.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'components/parents_tab.dart';
import 'components/personal_tab.dart';
import 'student_profile_update_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  final TextEditingController selectFileCon = TextEditingController();

  int selectedTab = 0;
  final tabDataList = ["Personal", "Family"];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    final studentHomeController = StudentHomePageController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentsProfileView();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        scaffoldKey: drawerKey,
        drawer: StudentCustomDrawer(),
        sliverAppBar: SliverAppBarWidget(
          expandedHeight: 200,
          title: Container(
            width: size(context).width,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                sizedBoxH(5),
                Row(
                  children: [
                    sizedBoxW(32),
                    Expanded(
                      child: Center(
                        child: GlobalText(
                          str: "Profile",
                          color: ColorRes.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                    sizedBoxW(10),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=> StudentProfileUpdateScreen());
                      },
                      child: const GlobalImageLoader(
                        imagePath: Images.editIc,
                        height: 22,
                        width: 22,
                        color: ColorRes.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                sizedBoxH(5),
              ],
            ),
          ),
          isBackIc: false,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
            child: StudentMenuBackgroundContainer(
              child: Row(
                children: [
                  // Profile Picture Section
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        colors: [
                          ColorRes.appColor.withValues(alpha: 0.8),
                          ColorRes.appColor,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorRes.appColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(37),
                        // color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(37),
                        child: GlobalImageLoader(
                          imagePath: homePageController.studentProfileModel?.student?.photo ?? "",
                          width: 69,
                          height: 69,
                          fit: BoxFit.cover,
                          imageFor: ImageFor.network,
                          errorBuilder: (ctx, exception, stackTrace)=> Center(
                            child: GlobalImageLoader(
                              imagePath: Images.studentProfileIc,
                              width: 50,
                              height: 50,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 16),

                  // Student Information Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Student Name
                        Container(
                          margin: EdgeInsets.only(bottom: 6),
                          child: Text(
                            homePageController.studentProfileModel?.student?.name ?? 'Student Name',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade800,
                              letterSpacing: 0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Class and Section
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                          decoration: BoxDecoration(
                            color: ColorRes.appColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.roboto(
                                fontSize: 11,
                                color: Colors.grey.shade700,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Class: ',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: ColorRes.appColor,
                                  ),
                                ),
                                TextSpan(
                                  text: homePageController.studentProfileModel?.studentDetail?.classData?.className ?? 'N/A',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' • ',
                                  style: GoogleFonts.roboto(
                                    color: ColorRes.appColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Section: ',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: ColorRes.appColor,
                                  ),
                                ),
                                TextSpan(
                                  text: homePageController.studentProfileModel?.studentDetail?.section?.sectionName ?? 'N/A',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Roll and Student ID
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.roboto(
                                fontSize: 11.5,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Roll: ',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                TextSpan(
                                  text: '${homePageController.studentProfileModel?.studentDetail?.roll ?? 'N/A'}',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' • ',
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ID: ',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                TextSpan(
                                  text: homePageController.studentProfileModel?.student?.uniqueId ?? 'N/A',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Session and Shift
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.roboto(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Session: ',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                TextSpan(
                                  text: homePageController.studentProfileModel?.studentDetail?.session?.year ?? 'N/A',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' • ',
                                  style: GoogleFonts.roboto(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Shift: ',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                TextSpan(
                                  text: homePageController.studentProfileModel?.studentDetail?.shift?.shiftName ?? 'N/A',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        slivers: [
          sliverSizedBoxH(10),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: tabDataList.asMap().entries.map((item) {
                  bool isSelected = selectedTab == item.key;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTab = item.key;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected
                              ? ColorRes.appColor
                              : Colors.transparent,
                          boxShadow: isSelected
                              ? [
                            BoxShadow(
                              color: ColorRes.appColor.withValues(alpha:0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                              : null,
                        ),
                        child: Center(
                          child: AnimatedScale(
                            scale: isSelected ? 1.05 : 1.0,
                            duration: const Duration(milliseconds: 200),
                            child: GlobalText(
                              str: item.value,
                              color: isSelected
                                  ? Colors.white
                                  : ColorRes.black.withValues(alpha:0.7),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: isSelected ? 13 : 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          sliverSizedBoxH(10),
          SliverToBoxAdapter(
            child: IndexedStack(
              key: ValueKey(selectedTab),
              index: selectedTab,
              children: [
                StudentPersonalTab(selectedTab: selectedTab),
                StudentParentsTab(),
                // StudentDocumentsTab(),
              ],
            ),
          ),

          sliverSizedBoxH(100),
        ],
      );
    });
  }
}