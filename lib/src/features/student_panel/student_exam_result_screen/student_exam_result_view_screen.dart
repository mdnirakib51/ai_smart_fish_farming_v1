import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../student_home_screen/model/student_exam_result_model.dart';
import 'components/mark_sheet_tab.dart';
import 'components/report_card_tab.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class StudentExamResultViewScreen extends StatefulWidget {
  final int? examResultId;
  const StudentExamResultViewScreen({
    super.key,
    required this.examResultId
  });

  @override
  State<StudentExamResultViewScreen> createState() => _StudentExamResultViewScreenState();
}

class _StudentExamResultViewScreenState extends State<StudentExamResultViewScreen> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  final TextEditingController selectFileCon = TextEditingController();

  int selectedTab = 0;
  final tabDataList = ["Report Card", "Mark Sheet"];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<StudentHomePageController>();
      controller.getStudentExamResult(examResultId: widget.examResultId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Method to generate and download PDF
  Future<void> _downloadMarkSheetPDF(BuildContext context, StudentExamResultModel? examResult) async {
    final homePageController = StudentHomePageController.current;
    if (examResult == null) return;

    final pdf = pw.Document();

    // Load signature image if available
    pw.ImageProvider? signatureImage;
    if (homePageController.studentProfileModel?.organization?.signature != null &&
        homePageController.studentProfileModel!.organization!.signature!.isNotEmpty) {
      try {
        // Method 1: If the signature is a network URL
        final response = await http.get(Uri.parse(homePageController.studentProfileModel!.organization!.signature!));
        if (response.statusCode == 200) {
          signatureImage = pw.MemoryImage(response.bodyBytes);
        }
      } catch (e) {
        print('Error loading signature image: $e');
        // If network loading fails, signatureImage remains null
      }
    }

    // Alternative method if signature is a base64 string:
    // if (homePageController.studentProfileModel?.organization?.signature != null &&
    //     homePageController.studentProfileModel!.organization!.signature!.isNotEmpty) {
    //   try {
    //     final bytes = base64Decode(homePageController.studentProfileModel!.organization!.signature!);
    //     signatureImage = pw.MemoryImage(bytes);
    //   } catch (e) {
    //     print('Error decoding base64 signature: $e');
    //   }
    // }

    // Alternative method if signature is an asset path:
    // if (homePageController.studentProfileModel?.organization?.signature != null &&
    //     homePageController.studentProfileModel!.organization!.signature!.isNotEmpty) {
    //   try {
    //     final ByteData data = await rootBundle.load(homePageController.studentProfileModel!.organization!.signature!);
    //     signatureImage = pw.MemoryImage(data.buffer.asUint8List());
    //   } catch (e) {
    //     print('Error loading asset signature: $e');
    //   }
    // }

    // Combine all subjects for the PDF
    List<dynamic> allSubjects = [];
    if (examResult.subjects?.regular != null) allSubjects.addAll(examResult.subjects!.regular!);
    if (examResult.subjects?.optional != null) allSubjects.addAll(examResult.subjects!.optional!);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      examResult.organization?.name ?? "",
                      style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      "Progress Report",
                      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.normal),
                    ),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      "Examination: ${examResult.exam?.name ?? ''}",
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Student Information
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Name: ${examResult.student?.name ?? ''}", style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 3),
                        pw.Text("Roll No.: ${examResult.student?.roll?.toString() ?? ''}", style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Class: ${examResult.student?.classs ?? ''}", style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 3),
                        pw.Text("Shift: ${examResult.student?.shift ?? ''}", style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Session: ${examResult.student?.session ?? ''}", style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Section: ${examResult.student?.section ?? ''}", style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 3),
                        pw.Text("Group: ${examResult.student?.group ?? ''}", style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),

              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 3),
                        pw.Text("Class Teacher Name: ${examResult.classTeacher?.name ?? ''}", style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 3),
                        pw.Text("Class Teacher Contact No: ${examResult.classTeacher?.phone ?? ''}", style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 15),

              // Subject Table
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                columnWidths: {
                  0: pw.FixedColumnWidth(20),
                  1: pw.FlexColumnWidth(3),
                  2: pw.FixedColumnWidth(40),
                  3: pw.FixedColumnWidth(35),
                  4: pw.FixedColumnWidth(25),
                  5: pw.FixedColumnWidth(35),
                  6: pw.FixedColumnWidth(25),
                  7: pw.FixedColumnWidth(25),
                  8: pw.FixedColumnWidth(30),
                  9: pw.FixedColumnWidth(25),
                  10: pw.FixedColumnWidth(35),
                },
                children: [
                  // Header Row
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("#", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Subject", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Full Marks", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Written", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("MCQ", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("SBA", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Total", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("LG", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("GP", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("GPA", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Highest", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                    ],
                  ),

                  // Subject Rows
                  ...allSubjects.asMap().entries.map((entry) {
                    int index = entry.key;
                    var subject = entry.value;
                    return pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${index + 1}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.subjectName ?? ''}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.fullMarks ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.written ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.objective ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.sba ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.totalMark ?? 0}", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradeName ?? ''}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradePoint ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradePoint ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.highestMark ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                      ],
                    );
                  }),

                  // Total Row
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.grey200),
                    children: [
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Total", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${examResult.summary?.totalMarks ?? 0}", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(examResult.summary?.gpa?.toStringAsFixed(2) ?? '0.00', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 15),

              // Add Continuous Assessment Section
              examResult.subjects?.continuousAssessment != null && examResult.subjects!.continuousAssessment!.isNotEmpty
                  ? pw.Text("Continuous Assessment:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))
                  : pw.SizedBox.shrink(),

              pw.SizedBox(height: 3),
              if (examResult.subjects?.continuousAssessment != null && examResult.subjects!.continuousAssessment!.isNotEmpty) ...[
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  columnWidths: {
                    0: pw.FixedColumnWidth(20),
                    1: pw.FlexColumnWidth(3),
                    2: pw.FixedColumnWidth(40),
                    3: pw.FixedColumnWidth(40),
                    4: pw.FixedColumnWidth(25),
                    5: pw.FixedColumnWidth(25),
                    6: pw.FixedColumnWidth(35),
                    7: pw.FixedColumnWidth(25),
                    8: pw.FixedColumnWidth(25),
                    9: pw.FixedColumnWidth(25),
                    10: pw.FixedColumnWidth(35),
                  },
                  children: [
                    // Continuous Assessment Header
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("#", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Subject", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Full Marks", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("SBA", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("CT", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Practical", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Total", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("GP", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("LG", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Highest", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      ],
                    ),

                    // Continuous Assessment Rows
                    ...examResult.subjects!.continuousAssessment!.asMap().entries.map((entry) {
                      int index = entry.key;
                      var subject = entry.value;
                      return pw.TableRow(
                        children: [
                          pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${index + 1}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                          pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(subject.subjectName ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                          pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.fullMarks ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                          subject.sba != null ? pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.sba ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)) : pw.SizedBox.shrink(),
                          subject.ct != null ? pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.ct ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)) : pw.SizedBox.shrink(),
                          subject.practical != null ? pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.practical ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)) : pw.SizedBox.shrink(),
                          pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.totalMark ?? 0}", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                          pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradePoint ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                          pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(subject.gradeName ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                          pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.highestMark ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        ],
                      );
                    }),
                  ],
                ),
                pw.SizedBox(height: 15),
              ],

              // Working Month Section with improved layout
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left Column
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Working Month:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 5),
                        pw.Text("Total Working Days", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Total Present", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Total Absent", style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 10),
                        pw.Text("Remarks:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.Text("Detention", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Daily Lesson", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Home Work", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Attentiveness", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Behavior", style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 10),
                        pw.Text("Class Teacher's Comments", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                  ),

                  // Middle Column
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 20),
                        pw.Text("Total students in Section: ${examResult.position?.sectionStudents ?? ''}", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Position in Section: ${examResult.position?.sectionPosition ?? ''}", style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 20),
                        pw.Text("", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("", style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),

                  // Right Column
                  pw.Expanded(
                    flex: 1,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 20),
                        pw.Text("Total students in Class: ${examResult.position?.classStudents ?? ''}", style: pw.TextStyle(fontSize: 10)),
                        pw.Text("Position in Class: ${examResult.position?.classPosition ?? ''}", style: pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 15),

              // Grading System Table
              if (examResult.gradingSystem != null && examResult.gradingSystem!.isNotEmpty) ...[
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(1),
                    2: pw.FlexColumnWidth(1),
                    3: pw.FlexColumnWidth(1),
                  },
                  children: [
                    pw.TableRow(
                      decoration: pw.BoxDecoration(color: PdfColors.grey300),
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Letter Grade", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Class Interval (100)", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Class Interval (50)", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Grade Point", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                      ],
                    ),
                    ...examResult.gradingSystem!.map((grade) => pw.TableRow(
                      children: [
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.grade ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.marks100 ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.marks50 ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                        pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.point ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
                      ],
                    )),
                  ],
                ),
                pw.SizedBox(height: 10),
              ],

              // Pass Marks section
              pw.Row(
                children: [
                  pw.Text("Pass Marks", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 10),
                  pw.Text("33(100)", style: pw.TextStyle(fontSize: 10)),
                  pw.SizedBox(width: 20),
                  pw.Text("17(50)", style: pw.TextStyle(fontSize: 10)),
                ],
              ),

              pw.Spacer(),

              // Signatures
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 30),
                      pw.Container(height: 2, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
                      pw.SizedBox(height: 5),
                      pw.Text("Signature of Class Teacher", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 30),
                      pw.Container(height: 2, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
                      pw.SizedBox(height: 5),
                      pw.Text("Signature of Coordinator", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 30),
                      pw.Container(height: 2, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
                      pw.SizedBox(height: 5),
                      pw.Text("Signature of Guardian", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                    ],
                  ),
                  pw.Column(
                    children: [
                      // Only show image if successfully loaded, otherwise show empty container
                      if (signatureImage != null) ...[
                        pw.Container(
                          height: 30,
                          width: 80,
                          child: pw.Image(signatureImage, fit: pw.BoxFit.contain),
                        ),
                      ] else ...[
                        pw.SizedBox(height: 30)
                      ],
                      pw.Container(height: 2, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
                      pw.SizedBox(height: 5),
                      pw.Text("Signature of Headmaster", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Save and share the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // Method to generate and download PDF
  // Future<void> _downloadMarkSheetPDF(BuildContext context, StudentExamResultModel? examResult) async {
  //   final homePageController = StudentHomePageController.current;
  //   if (examResult == null) return;
  //
  //   final pdf = pw.Document();
  //
  //   // Combine all subjects for the PDF
  //   List<dynamic> allSubjects = [];
  //   if (examResult.subjects?.regular != null) allSubjects.addAll(examResult.subjects!.regular!);
  //   if (examResult.subjects?.optional != null) allSubjects.addAll(examResult.subjects!.optional!);
  //
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       margin: pw.EdgeInsets.all(20),
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             // Header
  //             pw.Center(
  //               child: pw.Column(
  //                 children: [
  //                   pw.Text(
  //                     examResult.organization?.name ?? "",
  //                     style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
  //                   ),
  //                   pw.SizedBox(height: 5),
  //                   pw.Text(
  //                     "Progress Report",
  //                     style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.normal),
  //                   ),
  //                   pw.SizedBox(height: 3),
  //                   pw.Text(
  //                     "Examination: ${examResult.exam?.name ?? 'Half Yearly Examination 2025'}",
  //                     style: pw.TextStyle(fontSize: 12),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             pw.SizedBox(height: 20),
  //
  //             // Student Information
  //             pw.Row(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Expanded(
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.Text("Name: ${examResult.student?.name ?? 'Nafisa Farenn'}", style: pw.TextStyle(fontSize: 10)),
  //                       pw.SizedBox(height: 3),
  //                       pw.Text("Roll No.: ${examResult.student?.roll?.toString() ?? '6901'}", style: pw.TextStyle(fontSize: 10)),
  //                     ],
  //                   ),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.Text("Class: ${examResult.student?.classs ?? 'Six'}", style: pw.TextStyle(fontSize: 10)),
  //                       pw.SizedBox(height: 3),
  //                       pw.Text("Shift: ${examResult.student?.shift ?? 'Morning'}", style: pw.TextStyle(fontSize: 10)),
  //                     ],
  //                   ),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.Text("Session: ${examResult.student?.session ?? '2025'}", style: pw.TextStyle(fontSize: 10)),
  //                     ],
  //                   ),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.Text("Section: ${examResult.student?.section ?? 'Sec-C - Girls (6)'}", style: pw.TextStyle(fontSize: 10)),
  //                       pw.SizedBox(height: 3),
  //                       pw.Text("Group: ${examResult.student?.group ?? 'General'}", style: pw.TextStyle(fontSize: 10)),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //
  //             pw.Row(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Expanded(
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(height: 3),
  //                       pw.Text("Class Teacher Name: ${examResult.classTeacher?.name ?? 'SHAMIMA PARVIN'}", style: pw.TextStyle(fontSize: 10)),
  //                     ],
  //                   ),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(height: 3),
  //                       pw.Text("Class Teacher Contact No: ${examResult.classTeacher?.phone ?? '01821446425'}", style: pw.TextStyle(fontSize: 10)),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //
  //             pw.SizedBox(height: 15),
  //
  //             // Subject Table
  //             pw.Table(
  //               border: pw.TableBorder.all(width: 0.5),
  //               columnWidths: {
  //                 0: pw.FixedColumnWidth(20),
  //                 1: pw.FlexColumnWidth(3),
  //                 2: pw.FixedColumnWidth(40),
  //                 3: pw.FixedColumnWidth(35),
  //                 4: pw.FixedColumnWidth(25),
  //                 5: pw.FixedColumnWidth(35),
  //                 6: pw.FixedColumnWidth(25),
  //                 7: pw.FixedColumnWidth(25),
  //                 8: pw.FixedColumnWidth(30),
  //                 9: pw.FixedColumnWidth(25),
  //                 10: pw.FixedColumnWidth(35),
  //               },
  //               children: [
  //                 // Header Row
  //                 pw.TableRow(
  //                   decoration: pw.BoxDecoration(color: PdfColors.grey300),
  //                   children: [
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("#", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Subject", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Full Marks", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Written", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("MCQ", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("SBA", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Total", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("LG", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("GP", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("GPA", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Highest", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                   ],
  //                 ),
  //
  //                 // Subject Rows
  //                 ...allSubjects.asMap().entries.map((entry) {
  //                   int index = entry.key;
  //                   var subject = entry.value;
  //                   return pw.TableRow(
  //                     children: [
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${index + 1}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.subjectName ?? ''}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.fullMarks ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.written ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.objective ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.sba ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.totalMark ?? 0}", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradeName ?? ''}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradePoint ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradePoint ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.highestMark ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                     ],
  //                   );
  //                 }),
  //
  //                 // Total Row
  //                 pw.TableRow(
  //                   decoration: pw.BoxDecoration(color: PdfColors.grey200),
  //                   children: [
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Total", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${examResult.summary?.totalMarks ?? 0}", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(examResult.summary?.gpa?.toStringAsFixed(2) ?? '0.00', style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("")),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //
  //             pw.SizedBox(height: 15),
  //
  //             // Add Continuous Assessment Section
  //             examResult.subjects?.continuousAssessment != null && examResult.subjects!.continuousAssessment!.isNotEmpty
  //                 ? pw.Text("Continuous Assessment:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))
  //                 : pw.SizedBox.shrink(),
  //
  //             pw.SizedBox(height: 3),
  //             if (examResult.subjects?.continuousAssessment != null && examResult.subjects!.continuousAssessment!.isNotEmpty) ...[
  //               pw.Table(
  //                 border: pw.TableBorder.all(width: 0.5),
  //                 columnWidths: {
  //                   0: pw.FixedColumnWidth(20),
  //                   1: pw.FlexColumnWidth(3),
  //                   2: pw.FixedColumnWidth(40),
  //                   3: pw.FixedColumnWidth(40),
  //                   4: pw.FixedColumnWidth(25),
  //                   5: pw.FixedColumnWidth(25),
  //                   6: pw.FixedColumnWidth(35),
  //                   7: pw.FixedColumnWidth(25),
  //                   8: pw.FixedColumnWidth(25),
  //                   9: pw.FixedColumnWidth(25),
  //                   10: pw.FixedColumnWidth(35),
  //                 },
  //                 children: [
  //                   // Continuous Assessment Header
  //                   pw.TableRow(
  //                     decoration: pw.BoxDecoration(color: PdfColors.grey300),
  //                     children: [
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("#", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Subject", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Full Marks", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("SBA", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("CT", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Practical", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Total", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("GP", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("LG", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Highest", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     ],
  //                   ),
  //
  //                   // Continuous Assessment Rows
  //                   ...examResult.subjects!.continuousAssessment!.asMap().entries.map((entry) {
  //                     int index = entry.key;
  //                     var subject = entry.value;
  //                     return pw.TableRow(
  //                       children: [
  //                         pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${index + 1}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                         pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(subject.subjectName ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                         pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.fullMarks ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                         subject.sba != null ? pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.sba ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)) : pw.SizedBox.shrink(),
  //                         subject.ct != null ? pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.ct ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)) : pw.SizedBox.shrink(),
  //                         subject.practical != null ? pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.practical ?? '-'}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)) : pw.SizedBox.shrink(),
  //                         pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.totalMark ?? 0}", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                         pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.gradePoint ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                         pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(subject.gradeName ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                         pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("${subject.highestMark ?? 0}", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       ],
  //                     );
  //                   }),
  //                 ],
  //               ),
  //               pw.SizedBox(height: 15),
  //             ],
  //
  //             // Working Month Section with improved layout
  //             pw.Row(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 // Left Column
  //                 pw.Expanded(
  //                   flex: 1,
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.Text("Working Month:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
  //                       pw.SizedBox(height: 5),
  //                       pw.Text("Total Working Days", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Total Present", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Total Absent", style: pw.TextStyle(fontSize: 10)),
  //                       pw.SizedBox(height: 10),
  //                       pw.Text("Remarks:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
  //                       pw.Text("Detention", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Daily Lesson", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Home Work", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Attentiveness", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Behavior", style: pw.TextStyle(fontSize: 10)),
  //                       pw.SizedBox(height: 10),
  //                       pw.Text("Class Teacher's Comments", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 // Middle Column
  //                 pw.Expanded(
  //                   flex: 1,
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(height: 20),
  //                       pw.Text("Total students in Section: ${examResult.position?.sectionStudents ?? 38}", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Position in Section: ${examResult.position?.sectionPosition ?? 1}", style: pw.TextStyle(fontSize: 10)),
  //                       pw.SizedBox(height: 20),
  //                       pw.Text("", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("", style: pw.TextStyle(fontSize: 10)),
  //                     ],
  //                   ),
  //                 ),
  //
  //                 // Right Column
  //                 pw.Expanded(
  //                   flex: 1,
  //                   child: pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     children: [
  //                       pw.SizedBox(height: 20),
  //                       pw.Text("Total students in Class: ${examResult.position?.classStudents ?? 178}", style: pw.TextStyle(fontSize: 10)),
  //                       pw.Text("Position in Class: ${examResult.position?.classPosition ?? 1}", style: pw.TextStyle(fontSize: 10)),
  //                       pw.SizedBox(height: 30),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //
  //             pw.SizedBox(height: 15),
  //
  //             // Grading System Table
  //             if (examResult.gradingSystem != null && examResult.gradingSystem!.isNotEmpty) ...[
  //               pw.Table(
  //                 border: pw.TableBorder.all(width: 0.5),
  //                 columnWidths: {
  //                   0: pw.FlexColumnWidth(1),
  //                   1: pw.FlexColumnWidth(1),
  //                   2: pw.FlexColumnWidth(1),
  //                   3: pw.FlexColumnWidth(1),
  //                 },
  //                 children: [
  //                   pw.TableRow(
  //                     decoration: pw.BoxDecoration(color: PdfColors.grey300),
  //                     children: [
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Letter Grade", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Class Interval (100)", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Class Interval (50)", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text("Grade Point", style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
  //                     ],
  //                   ),
  //                   ...examResult.gradingSystem!.map((grade) => pw.TableRow(
  //                     children: [
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.grade ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.marks100 ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.marks50 ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                       pw.Padding(padding: pw.EdgeInsets.all(3), child: pw.Text(grade.point ?? '', style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center)),
  //                     ],
  //                   )),
  //                 ],
  //               ),
  //               pw.SizedBox(height: 10),
  //             ],
  //
  //             // Pass Marks section
  //             pw.Row(
  //               children: [
  //                 pw.Text("Pass Marks", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
  //                 pw.SizedBox(width: 10),
  //                 pw.Text("33(100)", style: pw.TextStyle(fontSize: 10)),
  //                 pw.SizedBox(width: 20),
  //                 pw.Text("17(50)", style: pw.TextStyle(fontSize: 10)),
  //               ],
  //             ),
  //
  //             pw.Spacer(),
  //
  //             // Signatures
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 pw.Column(
  //                   children: [
  //                     pw.Container(height: 30, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
  //                     pw.SizedBox(height: 5),
  //                     pw.Text("Signature of Class Teacher", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
  //                   ],
  //                 ),
  //                 pw.Column(
  //                   children: [
  //                     pw.Container(height: 30, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
  //                     pw.SizedBox(height: 5),
  //                     pw.Text("Signature of Coordinator", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
  //                   ],
  //                 ),
  //
  //                 pw.Column(
  //                   children: [
  //                     pw.Container(height: 30, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
  //                     pw.SizedBox(height: 5),
  //                     pw.Text("Signature of Guardian", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
  //                   ],
  //                 ),
  //                 pw.Column(
  //                   children: [
  //                     pw.Image(homePageController.studentProfileModel?.organization?.signature ?? ""),
  //                     pw.Container(height: 30, width: 80, decoration: pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide()))),
  //                     pw.SizedBox(height: 5),
  //                     pw.Text("Signature of Headmaster", style: pw.TextStyle(fontSize: 8), textAlign: pw.TextAlign.center),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //
  //   // Save and share the PDF
  //   await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => pdf.save(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Exam Results",
          expandedHeight: 60,
        ),
        bottomSheet: GlobalButtonWidget(
          str: 'Download Mark Sheet',
          height: 45,
          radius: 0,
          buttomColor: ColorRes.appColor,
          onTap: () async{
            if (homePageController.studentExamResultModel != null) {
              await _downloadMarkSheetPDF(context, homePageController.studentExamResultModel);
            }
          },
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
                StudentReportCardTab(),
                StudentMarkSheetTab(),
              ],
            ),
          ),
        ],
      );
    });
  }
}