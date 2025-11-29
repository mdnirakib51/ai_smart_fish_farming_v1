import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/constants/colors_resources.dart';
import 'package:ai_smart_fish_farming/src/global/widget/global_sized_box.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_text.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import '../../widget/student_menu_background_container.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../student_home_screen/model/student_class_routine_model.dart';
import 'widget/student_class_routine_widget.dart';

class StudentClassRoutineScreen extends StatefulWidget {
  const StudentClassRoutineScreen({super.key});

  @override
  State<StudentClassRoutineScreen> createState() => _StudentClassRoutineScreenState();
}

class _StudentClassRoutineScreenState extends State<StudentClassRoutineScreen> {

  String? selectedDay;
  List<String> weekDays = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List<String> weekDaysShort = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  @override
  void initState() {
    super.initState();
    // Get today's day and set as selected
    selectedDay = _getTodayDay();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final studentController = StudentHomePageController.current;
      studentController.getStudentClassSchedule();
    });
  }

  // Helper method to get today's day name
  String _getTodayDay() {
    final today = DateTime.now();
    final dayIndex = today.weekday; // Monday = 1, Sunday = 7

    // Convert to our week format (Saturday = 0, Sunday = 1, etc.)
    int adjustedIndex;
    if (dayIndex == 7) { // Sunday
      adjustedIndex = 1;
    } else if (dayIndex == 6) { // Saturday
      adjustedIndex = 0;
    } else { // Monday to Friday
      adjustedIndex = dayIndex + 1;
    }

    // Make sure index is within bounds
    if (adjustedIndex >= 0 && adjustedIndex < weekDays.length) {
      return weekDays[adjustedIndex];
    }

    // Fallback to Saturday if something goes wrong
    return 'Saturday';
  }

  // Helper method to get selected day routine
  Routine? getSelectedDayRoutine(StudentHomePageController controller) {
    if (controller.studentClassRoutineModel?.routine == null) return null;

    return controller.studentClassRoutineModel!.routine!.firstWhereOrNull(
          (routine) => routine.day == selectedDay,
    );
  }

  // Helper method to get all periods (excluding break time only)
  List<Periods> getAllPeriods(List<Periods>? periods) {
    if (periods == null) return [];

    return periods.where((period) =>
    period.periodName?.toLowerCase() != 'brake time'
    ).toList();
  }

  // Helper method to get stats
  Map<String, int> getStats(StudentHomePageController controller) {
    if (controller.studentClassRoutineModel?.routine == null) {
      return {'classes': 0, 'subjects': 0, 'teachers': 0};
    }

    Set<String> allSubjects = {};
    Set<int> allTeachers = {};
    int totalClasses = 0;

    for (var routine in (controller.studentClassRoutineModel?.routine ?? [])) {
      if (routine.periods != null && !routine.isHoliday!) {
        var allPeriods = getAllPeriods(routine.periods);

        for (var period in allPeriods) {
          // Count all periods as classes
          totalClasses++;

          // Only count subjects that have names
          if (period.subjectName != null && period.subjectName!.isNotEmpty) {
            allSubjects.add(period.subjectName!);
          }

          // Count unique teachers by their ID
          if (period.teacher != null && period.teacher!.id != null) {
            allTeachers.add(period.teacher!.id!);
          }
        }
      }
    }

    return {
      'classes': totalClasses,
      'subjects': allSubjects.length,
      'teachers': allTeachers.length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      final stats = getStats(homePageController);
      final selectedRoutine = getSelectedDayRoutine(homePageController);
      final activePeriods = selectedRoutine != null ? getAllPeriods(selectedRoutine.periods) : <Periods>[];

      return CustomScrollViewWidget(
        inAsyncCall: homePageController.isLoading,
        sliverAppBar: SliverAppBarWidget(
            titleText: "Class Routine",
            flexibleSpace: StudentFlexibleSpaceBackWidget(
              child: StudentMenuBackgroundContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    sizedBoxH(10),
                    Row(
                      children: [
                        // Classes
                        Expanded(
                          child: _buildStatItem(
                            icon: Icons.class_outlined,
                            value: '${stats['classes']}',
                            label: 'Classes',
                            color: Colors.blue,
                          ),
                        ),

                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white.withValues(alpha: 0.2),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),

                        // Subjects
                        Expanded(
                          child: _buildStatItem(
                            icon: Icons.book_outlined,
                            value: '${stats['subjects']}',
                            label: 'Subjects',
                            color: Colors.green,
                          ),
                        ),

                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white.withValues(alpha: 0.2),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),

                        // Teachers
                        Expanded(
                          child: _buildStatItem(
                            icon: Icons.people_outline,
                            value: '${stats['teachers']}',
                            label: 'Teachers',
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
        ),
        slivers: [
          sliverSizedBoxH(10),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  sizedBoxH(8),
                  // Day selector container
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: List.generate(weekDays.length, (index) {
                        final day = weekDays[index];
                        final dayShort = weekDaysShort[index];
                        final isSelected = selectedDay == day;

                        // Check if this day is a holiday
                        final dayRoutine = homePageController.studentClassRoutineModel?.routine?.firstWhereOrNull(
                              (routine) => routine.day == day,
                        );
                        final isHoliday = dayRoutine?.isHoliday ?? false;
                        final classCount = _getClassCount(dayRoutine);

                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedDay = day),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOutCubic,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorRes.appColor,
                                    ColorRes.appColor.withValues(alpha: 0.8),
                                    ColorRes.appColor.withValues(alpha: 0.9),
                                  ],
                                  stops: const [0.0, 0.7, 1.0],
                                )
                                    : isHoliday
                                    ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.red.withValues(alpha: 0.1),
                                    Colors.red.withValues(alpha: 0.05),
                                  ],
                                )
                                    : LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.grey.withValues(alpha: 0.02),
                                    Colors.grey.withValues(alpha: 0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: isHoliday && !isSelected
                                    ? Border.all(
                                  color: Colors.red.withValues(alpha: 0.4),
                                  width: 1.5,
                                )
                                    : isSelected
                                    ? Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  width: 2,
                                )
                                    : Border.all(
                                  color: Colors.grey.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                                boxShadow: isSelected
                                    ? [
                                  BoxShadow(
                                    color: ColorRes.appColor.withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: ColorRes.appColor.withValues(alpha: 0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                    spreadRadius: 1,
                                  ),
                                ]
                                    : [],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Status indicator
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: isSelected ? 8 : 6,
                                    height: isSelected ? 8 : 6,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white
                                          : isHoliday
                                          ? Colors.red.shade400
                                          : classCount != "0"
                                          ? ColorRes.appColor
                                          : Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                      boxShadow: isSelected || (isHoliday && !isSelected)
                                          ? [
                                        BoxShadow(
                                          color: (isSelected ? Colors.white : Colors.red)
                                              .withValues(alpha: 0.5),
                                          blurRadius: 6,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                          : null,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Day name
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : isHoliday
                                          ? Colors.red.shade700
                                          : Colors.grey.shade700,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                      fontSize: isSelected ? 14 : 13,
                                    ),
                                    child: Text(dayShort),
                                  ),

                                  const SizedBox(height: 6),

                                  // Status badge
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white.withValues(alpha: 0.25)
                                          : isHoliday
                                          ? Colors.red.withValues(alpha: 0.15)
                                          : classCount != "0"
                                          ? ColorRes.appColor.withValues(alpha: 0.1)
                                          : Colors.grey.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(10),
                                      border: isSelected
                                          ? Border.all(color: Colors.white.withValues(alpha: 0.3))
                                          : null,
                                    ),
                                    child: isHoliday
                                        ? Icon(
                                      Icons.beach_access,
                                      size: 10,
                                      color: isSelected ? Colors.white : Colors.red.shade600,
                                    )
                                        : GlobalText(
                                      str: classCount,
                                      color: isSelected
                                          ? Colors.white
                                          : classCount != "0"
                                          ? ColorRes.appColor
                                          : Colors.grey.shade500,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  // Active day indicator
                                  if (isSelected) ...[
                                    const SizedBox(height: 6),
                                    Container(
                                      width: 16,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.8),
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),

          sliverSizedBoxH(10),
          // Holiday message
          if (selectedRoutine?.isHoliday == true)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.holiday_village,
                      size: 48,
                      color: Colors.red.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 12),
                    const GlobalText(
                      str: "Holiday",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 4),
                    GlobalText(
                      str: "No classes scheduled for $selectedDay",
                      fontSize: 14,
                      color: Colors.red.shade700,
                    ),
                  ],
                ),
              ),
            )

          // No periods message
          else if (activePeriods.isEmpty)
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
                    Icon(
                      Icons.schedule_outlined,
                      size: 48,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(height: 12),
                    GlobalText(
                      str: "No periods found",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 4),
                    GlobalText(
                      str: "No periods available for $selectedDay",
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            )

          // All periods list (including those without subjects)
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList.builder(
                itemCount: activePeriods.length,
                itemBuilder: (context, index) {
                  final period = activePeriods[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: index == activePeriods.length - 1 ? 0 : 16),
                    child: StudentClassRoutineWidget(
                      startTime: period.startTime ?? '',
                      endTime: period.endTime ?? '',
                      subject: period.subjectName?.isNotEmpty == true
                          ? period.subjectName!
                          : 'No Subject Assigned',
                      teacher: period.subjectName?.isNotEmpty == true
                          ? period.teacher?.name ?? ""
                          : 'No Teacher Assigned',
                      imageUrl: period.teacher?.photo ?? "",
                      itemCount: index + 1,
                      periodName: period.periodName ?? '',
                      isSubjectAssigned: period.subjectName?.isNotEmpty == true,
                    ),
                  );
                },
              ),
            ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }

  String _getClassCount(Routine? routine) {
    if (routine == null || routine.periods == null) return "0";

    int classCount = routine.periods!
        .where((period) =>
    period.subjectName != null &&
        period.subjectName!.isNotEmpty &&
        period.periodName?.toLowerCase() != 'brake time')
        .length;

    return classCount.toString();
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        GlobalText(
          str: value,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(height: 2),
        GlobalText(
          str: label,
          fontSize: 11,
          color: Colors.black.withValues(alpha: 0.8),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}