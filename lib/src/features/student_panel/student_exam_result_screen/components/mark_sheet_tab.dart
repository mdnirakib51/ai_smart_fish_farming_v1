
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/constants/enum.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_couple_text_button.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../global/widget/text_widget.dart';
import '../../student_home_screen/controller/student_home_controller.dart';
import '../widget/student_subject_list_widget.dart';

class StudentMarkSheetTab extends StatelessWidget {
  const StudentMarkSheetTab({super.key});

  String _getGradeFromGPA(double gpa, List<dynamic>? gradingSystem) {
    if (gradingSystem == null) return 'N/A';

    for (var grade in gradingSystem) {
      double? point = double.tryParse(grade.point ?? '0');
      if (point != null && gpa >= point) {
        return grade.grade ?? 'N/A';
      }
    }
    return 'F';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      final examResult = homePageController.studentExamResultModel;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: GlobalImageLoader(
                              imagePath: examResult?.organization?.logo ?? "",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              imageFor: ImageFor.network,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Column(
                            children: [
                              GlobalText(
                                str: examResult?.organization?.name ?? "ST Edu",
                                fontWeight: FontWeight.bold,
                                maxLines: 2,
                                fontSize: 16,
                              ),
                              GlobalText(
                                str: examResult?.exam?.name ?? "Half Yearly Exam - 2025",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              GlobalText(
                                str: "Mark Sheet",
                                color: ColorRes.appColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Student Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CoupleTextButton(
                              firstText: "Name of Student:",
                              secondText: examResult?.student?.name ?? 'N/A',
                            ),
                            CoupleTextButton(
                              firstText: "Class:",
                              secondText: examResult?.student?.classs ?? 'N/A',
                            ),
                            CoupleTextButton(
                              firstText: "Section:",
                              secondText: examResult?.student?.section ?? 'N/A',
                            ),
                            CoupleTextButton(
                              firstText: "Roll No.:",
                              secondText: examResult?.student?.roll?.toString() ?? 'N/A',
                            ),
                          ],
                        ),
                      ),
                      sizedBoxW(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CoupleTextButton(
                              firstText: "Group:",
                              secondText: examResult?.student?.group ?? 'N/A',
                            ),
                            CoupleTextButton(
                              firstText: "Shift:",
                              secondText: examResult?.student?.shift ?? 'N/A',
                            ),
                            CoupleTextButton(
                              firstText: "Session:",
                              secondText: examResult?.student?.session ?? 'N/A',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              sizedBoxH(10),

              // Subjects Table
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(color: ColorRes.appColor.withValues(alpha: 0.1)),
                    child: Row(
                      children: const [
                        Expanded(flex: 1, child: TextWidget(str: "SL")),
                        Expanded(flex: 4, child: TextWidget(str: "Subject", textAlign: TextAlign.start)),
                        Expanded(flex: 2, child: TextWidget(str: "Score")),
                        Expanded(flex: 2, child: TextWidget(str: "GPA")),
                        Expanded(flex: 2, child: TextWidget(str: "Grade")),
                      ],
                    ),
                  ),

                  if (examResult?.subjects?.regular != null)
                    ...examResult?.subjects?.regular?.asMap().entries.map((entry) {
                      int index = entry.key;
                      var subject = entry.value;
                      return StudentSubjectListWidget(
                        index: index + 1,
                        subject: subject.subjectName ?? 'N/A',
                        score: subject.totalMark?.toString() ?? '0',
                        gpa: subject.gradePoint?.toString() ?? '0.0',
                        grade: subject.gradeName ?? 'N/A',
                      );
                    }).toList() ?? [],

                  if (examResult?.subjects?.optional != null)
                    ...examResult?.subjects?.optional?.asMap().entries.map((entry) {
                      int index = entry.key + (examResult.subjects?.regular?.length ?? 0);
                      var subject = entry.value;
                      return StudentSubjectListWidget(
                        index: index + 1,
                        subject: "${subject.subjectName ?? 'N/A'} (Optional)",
                        score: subject.totalMark?.toString() ?? '0',
                        gpa: subject.gradePoint?.toString() ?? '0.0',
                        grade: subject.gradeName ?? 'N/A',
                      );
                    }).toList() ?? [],

                  // Add Continuous Assessment subjects to the UI table if available
                  if (examResult?.subjects?.continuousAssessment != null)
                    ...examResult?.subjects?.continuousAssessment?.asMap().entries.map((entry) {
                      int index = entry.key + (examResult.subjects?.regular?.length ?? 0) + (examResult.subjects?.optional?.length ?? 0);
                      var subject = entry.value;
                      return StudentSubjectListWidget(
                        index: index + 1,
                        subject: "${subject.subjectName ?? 'N/A'} (CA)",
                        score: subject.totalMark?.toString() ?? '0',
                        gpa: subject.gradePoint?.toString() ?? '0.0',
                        grade: subject.gradeName ?? 'N/A',
                      );
                    }).toList() ?? [],
                ],
              ),

              sizedBoxH(10),

              // Summary and Download Section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sizedBoxW(10),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CoupleTextButton(
                            firstText: "Score: ",
                            secondText: examResult?.summary?.totalMarks?.toString() ?? '0',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: CoupleTextButton(
                            firstText: "CGPA: ",
                            secondText: examResult?.summary?.gpa?.toStringAsFixed(2) ?? '0.00',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CoupleTextButton(
                            firstText: "Grade: ",
                            secondText: _getGradeFromGPA(examResult?.summary?.gpa ?? 0.0, examResult?.gradingSystem),
                          ),
                        ),
                      ),
                      sizedBoxW(10),
                    ],
                  ),

                  sizedBoxH(20),

                  // Signatures Section
                  Row(
                    children: [
                      sizedBoxW(10),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              SizedBox(height: 40, width: 40),
                              GlobalText(
                                str: "Signature of Class Teacher",
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBoxW(10),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(height: 40, width: 40),
                              GlobalText(
                                str: "Signature of Guardian",
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBoxW(10),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              GlobalImageLoader(
                                imagePath: homePageController.studentProfileModel?.organization?.signature ?? "",
                                height: 40,
                                imageFor: ImageFor.network,
                                errorBuilder: (ctx, exception, stackTrace)=> SizedBox(height: 40, width: 40),
                              ),
                              GlobalText(
                                str: "Signature of Headmaster",
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBoxW(10),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}