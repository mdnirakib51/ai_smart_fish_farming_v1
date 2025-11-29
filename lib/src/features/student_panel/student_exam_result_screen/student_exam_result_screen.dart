import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import '../../widget/student_menu_background_container.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'student_exam_result_view_screen.dart';
import 'widget/student_exam_result_widget.dart';

class StudentExamResultScreen extends StatefulWidget {
  const StudentExamResultScreen({super.key});

  @override
  State<StudentExamResultScreen> createState() => _StudentExamResultScreenState();
}

class _StudentExamResultScreenState extends State<StudentExamResultScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<StudentHomePageController>();
      controller.getStudentExam();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        inAsyncCall: homePageController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Exam Results",
          expandedHeight: 200,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
            child: StudentMenuBackgroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, color: ColorRes.appColor, size: 24),
                      sizedBoxW(8),
                      GlobalText(
                        str: "Student Information",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  sizedBoxH(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              str: homePageController.studentExamModel?.student?.name ?? "N/A",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            sizedBoxH(4),
                            GlobalText(
                              str: "Roll: ${homePageController.studentExamModel?.student?.roll ?? "N/A"}",
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlobalText(
                            str: "Class: ${homePageController.studentExamModel?.student?.className ?? "N/A"}",
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          sizedBoxH(4),
                          GlobalText(
                            str: "Section: ${homePageController.studentExamModel?.student?.section ?? "N/A"}",
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        slivers: [
          sliverSizedBoxH(20),
          if (homePageController.studentExamModel?.exams != null && (homePageController.studentExamModel?.exams?.isNotEmpty ?? false))
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList.builder(
                itemCount: homePageController.studentExamModel?.exams?.length,
                itemBuilder: (context, index) {
                  final exam = homePageController.studentExamModel?.exams?[index];
                  return ExamResultSummaryWidget(
                    examName: exam?.examName ?? "N/A",
                    examDate: exam?.examDate ?? "N/A",
                    resultStatus: exam?.resultStatus ?? 0,
                    itemCount: index + 1,
                    onTap: () {
                      Get.to(() => StudentExamResultViewScreen(examResultId: exam?.id));
                    },
                  );
                },
              ),
            )
          else
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 60,
                      color: Colors.grey.shade400,
                    ),
                    sizedBoxH(16),
                    GlobalText(
                      str: "No Exam Results Found",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    sizedBoxH(8),
                    GlobalText(
                      str: "There are no exam results available at the moment.",
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      textAlign: TextAlign.center,
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