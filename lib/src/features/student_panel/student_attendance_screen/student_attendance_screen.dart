
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/widget/global_bottom_widget.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_dialog.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import '../../widget/student_menu_background_container.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'package:intl/intl.dart';
import '../student_home_screen/model/student_atte_monthly_report_model.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  String selectedMonth = DateFormat('MMM').format(DateTime.now());
  String selectedTab = 'Check In';
  DateTime currentDisplayDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<StudentHomePageController>();
      String currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
      controller.getStudentsAtteMonthlyReport(month: currentMonth);
    });
  }

  // Month/Year Picker Function
  Future<void> _showMonthYearPicker() async {
    int selectedYear = currentDisplayDate.year;
    int selectedMonth = currentDisplayDate.month;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (ctx, buildSetState){
          return GlobalDialog(
            title: 'Select Month & Year',
            children: [
              sizedBoxH(15),
              // Year Selector
              Container(
                width: size(context).width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorRes.grey.withValues(alpha: 0.2)
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        buildSetState(() {
                          selectedYear--;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorRes.grey.withValues(alpha: 0.5)
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 14,
                            color: ColorRes.black,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: GlobalText(
                            str: selectedYear.toString(),
                            color: ColorRes.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        buildSetState(() {
                          selectedYear++;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 4, top: 5, bottom: 5, left: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorRes.grey.withValues(alpha: 0.5)
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: ColorRes.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              sizedBoxH(15),
              // Month Grid
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final monthIndex = index + 1;
                  final monthName = DateFormat('MMM').format(DateTime(2024, monthIndex));
                  final isSelected = selectedMonth == monthIndex;

                  return GestureDetector(
                    onTap: () {
                      buildSetState(() {
                        selectedMonth = monthIndex;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorRes.appColor
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(color: ColorRes.appColor, width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          monthName,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              sizedBoxH(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: GlobalText(
                      str: "Cancel",
                      color: ColorRes.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  sizedBoxW(10),
                  GlobalButtonWidget(
                    str: "OK",
                    height: 35,
                    width: 80,
                    textSize: 11,
                    onTap: (){
                      buildSetState(() {
                        currentDisplayDate = DateTime(selectedYear, selectedMonth, 1);
                      });
                      _updateSelectedMonthAndFetchData();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),

              sizedBoxH(10),
            ],
          );
        });
      },
    );
  }

  void _navigateToPreviousMonth() {
    setState(() {
      currentDisplayDate = DateTime(currentDisplayDate.year, currentDisplayDate.month - 1, 1);
    });
    _updateSelectedMonthAndFetchData();
  }

  void _navigateToNextMonth() {
    setState(() {
      currentDisplayDate = DateTime(currentDisplayDate.year, currentDisplayDate.month + 1, 1);
    });
    _updateSelectedMonthAndFetchData();
  }

  void _updateSelectedMonthAndFetchData() {
    selectedMonth = DateFormat('MMM').format(currentDisplayDate);
    final controller = Get.find<StudentHomePageController>();
    String apiMonth = DateFormat('yyyy-MM').format(currentDisplayDate);
    controller.getStudentsAtteMonthlyReport(month: apiMonth);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'P':
        return Colors.green;
      case 'L':
        return Colors.orange;
      case 'A':
        return Colors.red;
      default:
        return Colors.grey.shade400;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'P':
        return 'P';
      case 'L':
        return 'L';
      case 'A':
        return 'A';
      default:
        return '';
    }
  }

  Widget _buildCalendarGrid(List<AttendanceMonthModel> attendanceList) {
    if (attendanceList.isEmpty) return Container();

    final year = currentDisplayDate.year;
    final month = currentDisplayDate.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayWeekday = DateTime(year, month, 1).weekday;

    List<Widget> dayWidgets = [];

    for (int i = 1; i < firstDayWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final attendance = attendanceList.firstWhereOrNull((att) => att.day == day);

      final status = attendance?.status ?? '-';
      final isToday = day == DateTime.now().day && month == DateTime.now().month && year == DateTime.now().year;

      dayWidgets.add(
        Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: _getStatusColor(status).withValues(alpha: status == '-' ? 0.1 : 0.8),
            borderRadius: BorderRadius.circular(8),
            border: isToday
                ? Border.all(color: ColorRes.appColor, width: 2)
                : null,
            boxShadow: status != '-' ? [
              BoxShadow(
                color: _getStatusColor(status).withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalText(
                str: day.toString(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: status == '-' ? Colors.grey.shade600 : Colors.white,
              ),
              if (status != '-')
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: GlobalText(
                    str: _getStatusText(status),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.0,
      children: dayWidgets,
    );
  }

  Widget _buildLegend(SummaryMonthlyModel? summary) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          GlobalText(
            str: 'Monthly Summary',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(
                  'Present',
                  summary?.present?.toString() ?? '0',
                  Colors.green,
                  'P'
              ),
              _buildLegendItem(
                  'Late',
                  summary?.late?.toString() ?? '0',
                  Colors.orange,
                  'L'
              ),
              _buildLegendItem(
                  'Absent',
                  summary?.absent?.toString() ?? '0',
                  Colors.red,
                  'A'
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String count, Color color, String symbol) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: GlobalText(
              str: symbol,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        GlobalText(
          str: label,
          fontSize: 12,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: GlobalText(
            str: count,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      final attendanceData = homePageController.studentAtteMonthlyReportModel;

      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Attendance",
          expandedHeight: 230,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
              child: Column(
                children: [
                  StudentMenuBackgroundContainer(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorRes.appColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.person, color: ColorRes.appColor, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: attendanceData?.student?.name ?? '',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(height: 4),
                              GlobalText(
                                str: 'ID: ${attendanceData?.student?.id} | Roll: ${attendanceData?.student?.roll}',
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(height: 2),
                              GlobalText(
                                str: 'Class: ${attendanceData?.student?.className} | Section: ${attendanceData?.student?.section}',
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  sizedBoxH(20),
                  Container(
                    width: size(context).width,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorRes.white.withValues(alpha: 0.2)
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _navigateToPreviousMonth,
                          child: Container(
                            padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorRes.white
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 14,
                                color: ColorRes.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: _showMonthYearPicker, // Add this line
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GlobalText(
                                      str: DateFormat('MMM yyyy').format(currentDisplayDate),
                                      color: ColorRes.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _navigateToNextMonth,
                          child: Container(
                            padding: EdgeInsets.only(right: 4, top: 5, bottom: 5, left: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorRes.white
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: ColorRes.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        ),
        slivers: [
          sliverSizedBoxH(20),

          // Calendar Header
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                    .map((day) => Expanded(
                  child: Center(
                    child: GlobalText(
                      str: day,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
              ),
            ),
          ),

          sliverSizedBoxH(10),

          // Calendar Grid
          if (attendanceData?.attendance != null)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: _buildCalendarGrid(attendanceData!.attendance!),
              ),
            ),

          sliverSizedBoxH(25),

          // Legend
          if (attendanceData?.summary != null)
            SliverToBoxAdapter(
              child: _buildLegend(attendanceData?.summary),
            ),

          sliverSizedBoxH(30),
        ],
      );
    });
  }
}