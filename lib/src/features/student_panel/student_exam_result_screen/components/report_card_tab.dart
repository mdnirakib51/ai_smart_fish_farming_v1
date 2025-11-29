import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/constants/enum.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../global/widget/text_widget.dart';
import '../../student_home_screen/controller/student_home_controller.dart';
import '../../student_home_screen/model/student_exam_result_model.dart';

class StudentReportCardTab extends StatelessWidget {
  const StudentReportCardTab({super.key});

  // Helper method to check if a column should be visible
  bool _shouldShowColumn(List<dynamic> subjects, String columnType) {
    for (var subject in subjects) {
      int? value;
      switch (columnType) {
        case 'written':
          value = subject.written;
          break;
        case 'objective':
          value = subject.objective;
          break;
        case 'practical':
          value = subject.practical;
          break;
        case 'ct':
          value = subject.ct;
          break;
        case 'sba':
          value = subject.sba;
          break;
        case 'oral':
          value = subject.oral;
          break;
        case 'diary':
          value = subject.diary;
          break;
      }
      if (value != null && value > 0) {
        return true;
      }
    }
    return false;
  }

  // Helper method to get visible columns
  List<String> _getVisibleColumns(List<dynamic> subjects) {
    List<String> columns = ['written', 'objective', 'practical', 'ct', 'sba', 'oral', 'diary'];
    return columns.where((column) => _shouldShowColumn(subjects, column)).toList();
  }

  // Helper method to get column header text
  String _getColumnHeader(String columnType) {
    switch (columnType) {
      case 'written':
        return 'Written';
      case 'objective':
        return 'MCQ';
      case 'practical':
        return 'Practical';
      case 'ct':
        return 'CT';
      case 'sba':
        return 'SBA';
      case 'oral':
        return 'Oral';
      case 'diary':
        return 'Diary';
      default:
        return '';
    }
  }

  // Helper method to get column value
  String _getColumnValue(dynamic subject, String columnType) {
    int? value;
    switch (columnType) {
      case 'written':
        value = subject.written;
        break;
      case 'objective':
        value = subject.objective;
        break;
      case 'practical':
        value = subject.practical;
        break;
      case 'ct':
        value = subject.ct;
        break;
      case 'sba':
        value = subject.sba;
        break;
      case 'oral':
        value = subject.oral;
        break;
      case 'diary':
        value = subject.diary;
        break;
    }
    return value?.toString() ?? '-';
  }

  // Helper method to get grade from GPA
  String _getGradeFromGPA(double gpa, List<GradingSystem>? gradingSystem) {
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

      if (examResult == null) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorRes.appColor),
            ),
          ),
        );
      }

      // Combine all subjects for column visibility check
      List<dynamic> allSubjects = [];
      if (examResult.subjects?.regular != null) allSubjects.addAll(examResult.subjects!.regular!);
      if (examResult.subjects?.optional != null) allSubjects.addAll(examResult.subjects!.optional!);

      List<String> visibleColumns = _getVisibleColumns(allSubjects);

      // Calculate dynamic table width based on visible columns
      double baseWidth = 460; // Base width for fixed columns
      double dynamicWidth = visibleColumns.length * 65.0;
      double totalTableWidth = baseWidth + dynamicWidth;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ColorRes.appColor.withAlpha(10), ColorRes.appColor.withAlpha(30)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorRes.appColor, width: 1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: GlobalImageLoader(
                            imagePath: examResult.organization?.logo ?? Images.appLogo,
                            height: 76,
                            width: 76,
                            fit: BoxFit.fill,
                            imageFor: ImageFor.network,
                          ),
                        ),
                      ),
                      sizedBoxW(15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GlobalText(
                              str: examResult.organization?.name ?? "ST Edu",
                              fontWeight: FontWeight.bold,
                              maxLines: 2,
                              fontSize: 18,
                              color: ColorRes.appColor,
                            ),
                            sizedBoxH(5),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: ColorRes.appColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: GlobalText(
                                str: examResult.exam?.name ?? "Half Yearly Exam - 2025",
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.white,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            sizedBoxH(8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: GlobalText(
                                str: "Progress Report",
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            sizedBoxH(20),

            // Student Information Section
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  _buildInfoRow("Name: ", examResult.student?.name ?? 'N/A'),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //_buildInfoRow("Name: ", examResult.student?.name ?? 'N/A'),
                            _buildInfoRow("Session: ", examResult.student?.session ?? 'N/A'),
                            _buildInfoRow("Roll No.: ", examResult.student?.roll?.toString() ?? 'N/A'),
                            _buildInfoRow("Group: ", examResult.student?.group ?? 'N/A'),
                          ],
                        ),
                      ),
                      sizedBoxW(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow("Class: ", examResult.student?.classs ?? 'N/A'),
                            _buildInfoRow("Section: ", examResult.student?.section ?? 'N/A'),
                            _buildInfoRow("Shift: ", examResult.student?.shift ?? 'N/A'),
                            //_buildInfoRow("", ''),
                          ],
                        ),
                      ),
                    ],
                  ),
                  sizedBoxH(10),
                  _buildInfoRow("Class Teacher Name: ", examResult.classTeacher?.name ?? 'N/A'),
                  _buildInfoRow("Class Teacher Contact No: ", examResult.classTeacher?.phone ?? 'N/A'),
                ],
              ),
            ),

            sizedBoxH(20),

            // Regular Subjects Table
            SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: totalTableWidth,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: ColorRes.appColor.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(8),
                            topRight: const Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            TextWidget(str: "#", width: 40, color: ColorRes.white, fontSize: 12),
                            Expanded(child: TextWidget(str: "Subject", textAlign: TextAlign.start, color: ColorRes.white, fontSize: 12)),
                            TextWidget(str: "Full\nMarks", width: 60, color: ColorRes.white, fontSize: 11),
                            ...visibleColumns.map((column) =>
                                TextWidget(str: _getColumnHeader(column), width: 65, color: ColorRes.white, fontSize: 11)
                            ),
                            TextWidget(str: "Total", width: 55, color: ColorRes.white, fontSize: 11),
                            TextWidget(str: "LG", width: 45, color: ColorRes.white, fontSize: 11),
                            TextWidget(str: "GPA", width: 45, color: ColorRes.white, fontSize: 11),
                            // TextWidget(str: "GPA", width: 50, color: ColorRes.white, fontSize: 11),
                            TextWidget(str: "Highest", width: 60, color: ColorRes.white, fontSize: 11),
                          ],
                        ),
                      ),

                      if (examResult.subjects?.regular != null)
                        ...examResult.subjects?.regular?.asMap().entries.map((entry) {
                          int index = entry.key;
                          var subject = entry.value;
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: (index % 2 == 0)
                                  ? ColorRes.appColor.withValues(alpha: 0.1)
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                TextWidget(str: "${index + 1}", width: 40, fontWeight: FontWeight.w500, fontSize: 11),
                                Expanded(child: TextWidget(str: subject.subjectName ?? "", textAlign: TextAlign.start, fontWeight: FontWeight.w500, fontSize: 11)),
                                TextWidget(str: subject.fullMarks?.toString() ?? "0", width: 60, fontWeight: FontWeight.w500, fontSize: 11),
                                ...visibleColumns.map((column) =>
                                    TextWidget(str: _getColumnValue(subject, column), width: 65, fontWeight: FontWeight.w500, fontSize: 11)
                                ),
                                TextWidget(str: subject.totalMark?.toString() ?? "0", width: 55, fontWeight: FontWeight.w600, fontSize: 11, color: ColorRes.appColor),
                                TextWidget(str: subject.gradeName ?? "", width: 45, fontWeight: FontWeight.w600, fontSize: 11),
                                TextWidget(str: subject.gradePoint?.toString() ?? "0", width: 45, fontWeight: FontWeight.w500, fontSize: 11),
                                // TextWidget(str: subject.gradePoint?.toString() ?? "0", width: 50, fontWeight: FontWeight.w500, fontSize: 11),
                                TextWidget(str: subject.highestMark?.toString() ?? "0", width: 60, fontWeight: FontWeight.w500, fontSize: 11),
                              ],
                            ),
                          );
                        }).toList() ?? [],

                      // Optional subjects
                      if (examResult.subjects?.optional != null)
                        ...examResult.subjects?.optional?.asMap().entries.map((entry) {
                          int index = entry.key + (examResult.subjects?.regular?.length ?? 0);
                          var subject = entry.value;
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: (index % 2 == 0)
                                  ? Colors.green[25]
                                  : Colors.white,
                            ),
                            child: Row(
                              children: [
                                TextWidget(str: "${index + 1}", width: 40, fontWeight: FontWeight.w500, fontSize: 11),
                                Expanded(child: TextWidget(str: "${subject.subjectName ?? ""} (Optional)", textAlign: TextAlign.start, fontWeight: FontWeight.w500, fontSize: 11, color: Colors.green[700])),
                                TextWidget(str: subject.fullMarks?.toString() ?? "0", width: 60, fontWeight: FontWeight.w500, fontSize: 11),
                                ...visibleColumns.map((column) =>
                                    TextWidget(str: _getColumnValue(subject, column), width: 65, fontWeight: FontWeight.w500, fontSize: 11)
                                ),
                                TextWidget(str: subject.totalMark?.toString() ?? "0", width: 55, fontWeight: FontWeight.w600, fontSize: 11, color: Colors.green[700]),
                                TextWidget(str: subject.gradeName ?? "", width: 45, fontWeight: FontWeight.w600, fontSize: 11),
                                TextWidget(str: subject.gradePoint?.toString() ?? "0", width: 45, fontWeight: FontWeight.w500, fontSize: 11),
                                // TextWidget(str: subject.gradePoint?.toString() ?? "0", width: 50, fontWeight: FontWeight.w500, fontSize: 11),
                                TextWidget(str: subject.highestMark?.toString() ?? "0", width: 60, fontWeight: FontWeight.w500, fontSize: 11),
                              ],
                            ),
                          );
                        }).toList() ?? [],

                      // Total Row
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: ColorRes.appColor.withAlpha(50),
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(8),
                            bottomRight: const Radius.circular(8),
                          ),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: totalTableWidth,
                            child: Row(
                              children: [
                                TextWidget(str: "", width: 40, fontWeight: FontWeight.bold),
                                Expanded(child: TextWidget(str: "Total", textAlign: TextAlign.start, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextWidget(str: "", width: 60, fontWeight: FontWeight.bold),
                                ...visibleColumns.map((column) =>
                                    TextWidget(str: "", width: 65, fontWeight: FontWeight.bold)
                                ),
                                TextWidget(str: examResult.summary?.totalMarks?.toString() ?? "0", width: 55, fontWeight: FontWeight.bold, fontSize: 12, color: ColorRes.appColor),
                                TextWidget(str: "", width: 45, fontWeight: FontWeight.bold),
                                TextWidget(str: examResult.summary?.gpa?.toStringAsFixed(2) ?? "", width: 45, fontWeight: FontWeight.bold),
                                // TextWidget(str: "", width: 50, fontWeight: FontWeight.bold),
                                TextWidget(str: "", width: 60, fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Continuous Assessment Section
            if (examResult.subjects?.continuousAssessment != null && examResult.subjects!.continuousAssessment!.isNotEmpty) ...[
              sizedBoxH(20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GlobalText(
                          str: "Continuous Assessment",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    sizedBoxH(15),
                    ...examResult.subjects?.continuousAssessment?.asMap().entries.map((entry) {
                      var subject = entry.value;
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange[100]!),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: TextWidget(str: "Subject: ${subject.subjectName}", textAlign: TextAlign.start, fontWeight: FontWeight.w600, fontSize: 12)),
                                Expanded(child: TextWidget(str: "Full Marks: ${subject.fullMarks}", textAlign: TextAlign.end, fontWeight: FontWeight.w500, fontSize: 11)),
                              ],
                            ),
                            sizedBoxH(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                subject.sba != null && subject.sba != 0 ? Expanded(child: TextWidget(str: "SBA\n${subject.sba ?? 0}", fontWeight: FontWeight.w500, fontSize: 11)) : SizedBox.shrink(),
                                subject.ct != null && subject.ct != 0 ? Expanded(child: TextWidget(str: "CT\n${subject.ct ?? 0}", fontWeight: FontWeight.w500, fontSize: 11)) : SizedBox.shrink(),
                                subject.practical != null && subject.practical != 0 ? Expanded(child: TextWidget(str: "Prac.\n${subject.practical ?? 0}", fontWeight: FontWeight.w500, fontSize: 11)) : SizedBox.shrink(),
                                Expanded(child: TextWidget(str: "Total\n${subject.totalMark}", fontWeight: FontWeight.w600, fontSize: 11, color: Colors.orange[700])),
                                Expanded(child: TextWidget(str: "GP\n${subject.gradePoint}", fontWeight: FontWeight.w600, fontSize: 11)),
                                Expanded(child: TextWidget(str: "LG\n${subject.gradeName}", fontWeight: FontWeight.w600, fontSize: 11)),
                                Expanded(child: TextWidget(str: "High\n${subject.highestMark}", fontWeight: FontWeight.w600, fontSize: 11)),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList() ?? [],
                  ],
                ),
              ),
            ],

            sizedBoxH(20),

            // Summary Section
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[50]!, Colors.blue[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorRes.appColor.withAlpha(100)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSummaryCard("Total Score", examResult.summary?.totalMarks?.toString() ?? '0', Colors.blue),
                      _buildSummaryCard("CGPA", examResult.summary?.gpa?.toStringAsFixed(2) ?? '0.00', Colors.green),
                      _buildSummaryCard("Grade", _getGradeFromGPA(examResult.summary?.gpa ?? 0.0, examResult.gradingSystem), Colors.orange),
                    ],
                  ),
                  sizedBoxH(15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow("Students in Section:", examResult.position?.sectionStudents?.toString() ?? '0'),
                            _buildInfoRow("Students in Class:", examResult.position?.classStudents?.toString() ?? '0'),
                          ],
                        ),
                      ),
                      sizedBoxW(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow("Position in Section:", examResult.position?.sectionPosition?.toString() ?? '0'),
                            _buildInfoRow("Position in Class:", examResult.position?.classPosition?.toString() ?? '0'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Grading System
            if (examResult.gradingSystem != null && examResult.gradingSystem!.isNotEmpty) ...[
              sizedBoxH(20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple[200]!),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GlobalText(
                        str: "Grading System",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    sizedBoxH(15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: TextWidget(str: "Letter Grade", fontWeight: FontWeight.bold, fontSize: 12, color: Colors.purple[700])),
                        Expanded(child: TextWidget(str: "Class Interval (100)", fontWeight: FontWeight.bold, fontSize: 12, color: Colors.purple[700])),
                        Expanded(child: TextWidget(str: "Class Interval (50)", fontWeight: FontWeight.bold, fontSize: 12, color: Colors.purple[700])),
                        Expanded(child: TextWidget(str: "Grade Point", fontWeight: FontWeight.bold, fontSize: 12, color: Colors.purple[700])),
                      ],
                    ),
                    sizedBoxH(10),
                    ...examResult.gradingSystem?.map((grade) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 6),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.purple[100]!),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: TextWidget(str: grade.grade ?? "", fontWeight: FontWeight.w600, fontSize: 11)),
                            Expanded(child: TextWidget(str: grade.marks100 ?? "", fontWeight: FontWeight.w500, fontSize: 11)),
                            Expanded(child: TextWidget(str: grade.marks50 ?? "", fontWeight: FontWeight.w500, fontSize: 11)),
                            Expanded(child: TextWidget(str: grade.point ?? "", fontWeight: FontWeight.w600, fontSize: 11, color: Colors.purple[700])),
                          ],
                        ),
                      );
                    }).toList() ?? [],
                  ],
                ),
              ),
            ],

            sizedBoxH(30),

            // Signatures Section
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSignatureSection(title: "Signature of Class Teacher"),

                  sizedBoxW(5),
                  _buildSignatureSection(title: "Signature of Guardian"),

                  sizedBoxW(5),
                  _buildSignatureSection(signature: homePageController.studentProfileModel?.organization?.signature, title: "Signature of Headmaster"),
                ],
              ),
            ),

            sizedBoxH(70),
          ],
        ),
      );
    });
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            str: label,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.grey[700],
          ),
          Expanded(
            child: GlobalText(
              str: value,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: ColorRes.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(100)),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(50),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          GlobalText(
            str: title,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
          sizedBoxH(5),
          GlobalText(
            str: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureSection({String? signature, required String title}) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[400]!, width: 1)),
            ),
            child: GlobalImageLoader(
              imagePath: signature ?? "",
              height: 40,
              imageFor: ImageFor.network,
              errorBuilder: (ctx, exception, stackTrace)=> SizedBox(height: 40, width: 40),
            ),
          ),
          sizedBoxH(8),
          SizedBox(
            width: 100,
            child: GlobalText(
              str: title,
              fontWeight: FontWeight.w500,
              fontSize: 10,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
