import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import '../../widget/student_menu_background_container.dart';
import 'widget/student_subject_info_widget.dart';

class StudentSubjectScreen extends StatefulWidget {
  const StudentSubjectScreen({super.key});

  @override
  State<StudentSubjectScreen> createState() => _StudentSubjectScreenState();
}

class _StudentSubjectScreenState extends State<StudentSubjectScreen> {

  @override
  void initState() {
    super.initState();
    final studentHomeController = StudentHomePageController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentSubjectList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      final subjectData = homePageController.studentSubjectList;

      return CustomScrollViewWidget(
        inAsyncCall: homePageController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Subject",
          flexibleSpace: StudentFlexibleSpaceBackWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StudentMenuBackgroundContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Student Information
                      if (subjectData?.studentDetails != null) ...[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ColorRes.appColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.person,
                                color: ColorRes.appColor,
                                size: 20,
                              ),
                            ),
                            sizedBoxW(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GlobalText(
                                    str: 'Student ID: ${subjectData!.studentDetails!.uniqueId ?? subjectData.studentDetails!.regNo ?? 'N/A'}',
                                    color: ColorRes.appColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sizedBoxH(2),
                                  GlobalText(
                                    str: 'Roll: ${subjectData.studentDetails!.roll ?? 'N/A'}',
                                    color: ColorRes.deep400,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH(10),

                        // Class Information
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ColorRes.appColor.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ColorRes.appColor.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlobalText(
                                      str: 'Class: ${subjectData.studentDetails!.classData?.className ?? 'N/A'}',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ColorRes.black,
                                    ),
                                    sizedBoxH(2),
                                    GlobalText(
                                      str: 'Section: ${subjectData.studentDetails!.section?.sectionName ?? 'N/A'}',
                                      fontSize: 11,
                                      color: ColorRes.deep400,
                                    ),
                                  ],
                                ),
                              ),
                              if (subjectData.studentDetails!.group != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: ColorRes.appColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: GlobalText(
                                    str: subjectData.studentDetails?.group?.groupName ?? '',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        slivers: [
          sliverSizedBoxH(10),

          // Loading State
          if (homePageController.isLoading)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorRes.appColor,
                  ),
                ),
              ),
            )

          // Error State
          else if (homePageController.hasError)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 40),
                    sizedBoxH(10),
                    GlobalText(
                      str: 'Failed to load subjects',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    sizedBoxH(5),
                    GlobalText(
                      str: 'Please try again later',
                      fontSize: 14,
                      color: Colors.red.withValues(alpha: 0.8),
                    ),
                  ],
                ),
              ),
            )

          // Subject Data
          else if (subjectData?.subjects != null && subjectData!.subjects!.isNotEmpty) ...[
              // Subject Count Header
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorRes.appColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ColorRes.appColor.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorRes.appColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.menu_book,
                          color: ColorRes.appColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              str: 'Total ${subjectData.subjects!.length} Subjects',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorRes.black,
                            ),
                            const SizedBox(height: 2),
                            GlobalText(
                              str: 'All subjects for current session',
                              fontSize: 12,
                              color: ColorRes.deep400,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: ColorRes.appColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GlobalText(
                          str: '${subjectData.subjects!.length}',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              sliverSizedBoxH(10),

              // Subject List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.builder(
                  itemCount: subjectData.subjects!.length,
                  itemBuilder: (context, index) {
                    final subject = subjectData.subjects![index];
                    return StudentSubjectInfoWidget(
                      subject: subject.subjectName ?? 'Subject',
                      teacherName: subject.teacherName ?? 'Teacher',
                      itemCount: index + 1,
                    );
                  },
                ),
              ),
            ]

            // No Data State
            else
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.menu_book, color: Colors.grey, size: 40),
                      sizedBoxH(10),
                      GlobalText(
                        str: 'No subjects available',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
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