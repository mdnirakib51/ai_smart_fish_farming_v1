import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'widget/student_evaluated_tab.dart';
import 'widget/student_panding_tab.dart';
import 'widget/submitted_tab.dart';

class StudentHomeworkScreen extends StatefulWidget {
  const StudentHomeworkScreen({super.key});

  @override
  State<StudentHomeworkScreen> createState() => _StudentHomeworkScreenState();
}

class _StudentHomeworkScreenState extends State<StudentHomeworkScreen> {

  int selectedTab = 0;
  final tabDataList = ["Pending", "Submitted", "Evaluated"];

  final List<String?> uploadedFiles = List.filled(7, null);
  final List<bool> submissionStatus = List.filled(7, false);

  Future<void> selectFile(int index) async {
    setState(() {
      uploadedFiles[index] = 'assignment_${index + 1}.pdf';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File ${uploadedFiles[index]} uploaded!')),
      );
    });
  }

  Future<void> submitAssignment(int index) async {
    // Simulate submission
    setState(() {
      submissionStatus[index] = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Assignment ${index + 1} submitted!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Homework",
          expandedHeight: 60,
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
              index: selectedTab,
              children: [
                StudentPendingTab(selectedTab: selectedTab),
                StudentSubmittedTab(),
                StudentEvaluatedTab(),
              ],
            ),
          ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }
}
