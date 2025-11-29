import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/service/auth/controller/auth_controller.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../../service/auth/model/holyday_model.dart';
import 'widget/student_holiday_widget.dart';

class StudentHolyDayScreen extends StatefulWidget {
  const StudentHolyDayScreen({super.key});

  @override
  State<StudentHolyDayScreen> createState() => _StudentHolyDayScreenState();
}

class _StudentHolyDayScreenState extends State<StudentHolyDayScreen> {
  int selectedMonthIndex = DateTime.now().month;

  final List<String> months = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  final List<String> dayNames = const [
    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
  ];

  @override
  void initState() {
    super.initState();
    final authController = AuthController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      authController.getHolyDayView();
    });
  }

  // Helper method to extract holiday days from the selected month
  List<int> getHolidayDaysForMonth(AuthController authController, int month) {
    if (authController.holyDayModel?.holiday == null) return [];

    List<int> holidayDays = [];
    for (var holiday in authController.holyDayModel!.holiday!) {
      if (holiday.date != null) {
        try {
          // Assuming date format is "dd/mm/yyyy" or "yyyy-mm-dd"
          DateTime holidayDate;
          if (holiday.date!.contains('/')) {
            final parts = holiday.date!.split('/');
            if (parts.length == 3) {
              // Handle dd/mm/yyyy format
              holidayDate = DateTime(
                  int.parse(parts[2]), // year
                  int.parse(parts[1]), // month
                  int.parse(parts[0])  // day
              );
            } else {
              continue;
            }
          } else if (holiday.date!.contains('-')) {
            // Handle yyyy-mm-dd format
            holidayDate = DateTime.parse(holiday.date!);
          } else {
            continue;
          }

          if (holidayDate.month == month) {
            holidayDays.add(holidayDate.day);
          }
        } catch (e) {
          // Skip invalid dates
          continue;
        }
      }
    }
    return holidayDays;
  }

  // Helper method to get holidays for current month
  List<Holiday> getHolidaysForCurrentMonth(AuthController authController) {
    if (authController.holyDayModel?.holiday == null) return [];

    return authController.holyDayModel!.holiday!.where((holiday) {
      if (holiday.date != null) {
        try {
          DateTime holidayDate;
          if (holiday.date!.contains('/')) {
            final parts = holiday.date!.split('/');
            if (parts.length == 3) {
              holidayDate = DateTime(
                  int.parse(parts[2]), // year
                  int.parse(parts[1]), // month
                  int.parse(parts[0])  // day
              );
            } else {
              return false;
            }
          } else if (holiday.date!.contains('-')) {
            holidayDate = DateTime.parse(holiday.date!);
          } else {
            return false;
          }

          return holidayDate.month == selectedMonthIndex;
        } catch (e) {
          return false;
        }
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      final daysInMonth = DateTime(2025, selectedMonthIndex + 1, 0).day;
      final firstDayOfMonth = DateTime(2025, selectedMonthIndex, 1).weekday % 7;
      final totalCells = firstDayOfMonth + daysInMonth;
      final totalRows = (totalCells / 7).ceil();

      // Get holiday days for the selected month
      final List<int> highlightDays = getHolidayDaysForMonth(authController, selectedMonthIndex);

      // Get holidays for the list view
      final List<Holiday> currentMonthHolidays = getHolidaysForCurrentMonth(authController);

      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Holy Day",
          expandedHeight: 60,
        ),
        slivers: [
          sliverSizedBoxH(10),

          /// Calendar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        Container(
                          width: size(context).width,
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ColorRes.white200.withValues(alpha: 0.1)
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMonthIndex = selectedMonthIndex > 1 ? selectedMonthIndex - 1 : 12;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorRes.grey.withValues(alpha: 0.2)
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
                                      str: months[selectedMonthIndex - 1],
                                      color: ColorRes.appColor,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMonthIndex = selectedMonthIndex < 12 ? selectedMonthIndex + 1 : 1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 4, top: 5, bottom: 5, left: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: ColorRes.grey.withValues(alpha: 0.2)
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: dayNames
                              .map((dayName) => Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            child: GlobalText(
                              str: dayName,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ))
                              .toList(),
                        ),

                        const SizedBox(height: 8),

                        // Calendar grid
                        Column(
                          children: List.generate(totalRows, (rowIndex) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(7, (colIndex) {
                                final cellIndex = rowIndex * 7 + colIndex;
                                if (cellIndex < firstDayOfMonth) {
                                  return SizedBox(
                                    width: 32,
                                    height: 32,
                                  );
                                }
                                final day = cellIndex - firstDayOfMonth + 1;
                                if (day > daysInMonth) {
                                  return SizedBox(
                                    width: 32,
                                    height: 32,
                                  );
                                }

                                final isHoliday = highlightDays.contains(day);

                                return Container(
                                  width: 32,
                                  height: 32,
                                  margin: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isHoliday
                                        ? ColorRes.red
                                        : Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: GlobalText(
                                    str: '$day',
                                    fontSize: 12,
                                    color: isHoliday ? Colors.white : Colors.black,
                                  ),
                                );
                              }),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          sliverSizedBoxH(20),

          /// Holiday List - Show loading, error, or actual data
          authController.isLoading
              ? SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : authController.hasError
              ? SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 16),
                  GlobalText(
                    str: "Failed to load holidays",
                    color: Colors.red,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => authController.getHolyDayView(),
                    child: Text("Retry"),
                  ),
                ],
              ),
            ),
          )
              : currentMonthHolidays.isEmpty
              ? SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.event_busy, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    GlobalText(
                      str: "No holidays found for ${months[selectedMonthIndex - 1]}",
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          )
              : SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.builder(
              itemCount: currentMonthHolidays.length,
              itemBuilder: (context, index) {
                final holiday = currentMonthHolidays[index];
                return StudentHolidayWidget(
                  title: holiday.holiday ?? "Holiday ${index + 1}",
                  description: "${holiday.day ?? 'Holiday'} - ${holiday.noOfDays ?? 1} day(s)",
                  date: holiday.date ?? "",
                  itemCount: index + 1,
                );
              },
            ),
          ),

          sliverSizedBoxH(20),
        ],
      );
    });
  }
}