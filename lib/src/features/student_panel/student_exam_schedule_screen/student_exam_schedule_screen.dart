import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import '../../widget/student_menu_background_container.dart';
import '../student_home_screen/controller/student_home_controller.dart';

class StudentExamScheduleScreen extends StatefulWidget {
  const StudentExamScheduleScreen({super.key});

  @override
  State<StudentExamScheduleScreen> createState() => _StudentExamScheduleScreenState();
}

class _StudentExamScheduleScreenState extends State<StudentExamScheduleScreen> {

  @override
  void initState() {
    super.initState();
    final controller = StudentHomePageController.current;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getStudentExamRoutine();
    });
  }

  Future<void> _launchRoutineUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          "Error",
          "Could not open the routine PDF",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to open routine: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        inAsyncCall: homePageController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Exam Schedule",
          expandedHeight: 200,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
              child: StudentMenuBackgroundContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school, color: ColorRes.appColor, size: 24),
                        sizedBoxW(8),
                        GlobalText(
                          str: "Institution Information",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    sizedBoxH(12),
                    GlobalText(
                      str: homePageController.studentExamRoutineModel?.orgInfo?.systemTitle ?? "N/A",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    sizedBoxH(4),
                    GlobalText(
                      str: homePageController.studentExamRoutineModel?.orgInfo?.address ?? "N/A",
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
          ),
        ),
        slivers: [
          sliverSizedBoxH(20),

          // Exam Routines Section
          if (homePageController.studentExamRoutineModel?.examRoutines != null && (homePageController.studentExamRoutineModel?.examRoutines?.isNotEmpty ?? false))
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList.builder(
                itemCount: homePageController.studentExamRoutineModel?.examRoutines?.length,
                itemBuilder: (context, index) {
                  final routine = homePageController.studentExamRoutineModel?.examRoutines?[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: ColorRes.appColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: GlobalText(
                                  str: routine?.exam ?? "N/A",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.appColor,
                                ),
                              ),
                              const Spacer(),
                              GlobalText(
                                str: routine?.date ?? "N/A",
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                          sizedBoxH(8),
                          GlobalText(
                            str: routine?.title ?? "N/A",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          sizedBoxH(8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (routine?.className?.className != null)
                                      GlobalText(
                                        str: "Class: ${routine?.className!.className}",
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                    if (routine?.section != null)
                                      GlobalText(
                                        str: "Section: ${routine?.section}",
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (routine?.yearName?.year != null)
                                      GlobalText(
                                        str: "Year: ${routine?.yearName!.year}",
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                    if (routine?.type != null)
                                      GlobalText(
                                        str: "Type: ${routine?.type}",
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          sizedBoxH(12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: routine?.routine != null && (routine?.routine!.isNotEmpty ?? false)
                                  ? () => _launchRoutineUrl(routine!.routine!)
                                  : null,
                              icon: const Icon(Icons.visibility, size: 18, color: ColorRes.white),
                              label: const GlobalText(
                                str: "View Routine",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorRes.appColor,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: Colors.grey.shade300,
                                disabledForegroundColor: Colors.grey.shade500,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      Icons.schedule,
                      size: 60,
                      color: Colors.grey.shade400,
                    ),
                    sizedBoxH(16),
                    GlobalText(
                      str: "No Exam Schedule Found",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    sizedBoxH(8),
                    GlobalText(
                      str: "There are no exam schedules available at the moment.",
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