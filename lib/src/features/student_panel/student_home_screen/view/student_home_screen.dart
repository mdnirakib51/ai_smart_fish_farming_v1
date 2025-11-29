
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/utils/show_toast.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/enum.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../../global/model.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../service/auth/controller/auth_controller.dart';
import '../../student_assignments_screen/student_assignments_screen.dart';
import '../../student_attendance_screen/student_attendance_screen.dart';
import '../../student_class_routine/student_class_routine_screen.dart';
import '../../student_drawer/view/student_drawer_screen.dart';
import '../../student_exam_result_screen/student_exam_result_screen.dart';
import '../../student_exam_schedule_screen/student_exam_schedule_screen.dart';
import '../../student_holy_day_screen/student_holy_day_screen.dart';
import '../../student_homework_screen/student_homework_screen.dart';
import '../../student_leave_screen/student_leave_screen.dart';
import '../../student_lecture_sheet_screen/student_lecture_sheet_screen.dart';
import '../../student_library_screen/student_library_book_list_screen.dart';
import '../../student_notification_screen/student_notification_screen.dart';
import '../../student_subject_screen/student_subject_screen.dart';
import '../../student_teacher_screen/student_teacher_screen.dart';
import '../../../widget/student_flexible_space_back_widget.dart';
import '../../../widget/student_menu_background_container.dart';
import '../controller/student_home_controller.dart';
import 'widget/student_home_widget.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  List<GlobalMenuModel>? menuItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final studentHomeController = StudentHomePageController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentsProfileView();
      studentHomeController.getStudentsNotice();
    });

    menuItem = [
      GlobalMenuModel(img: Images.attendanceIc, text: 'Attendance', slug: 'attendance', color: ColorRes.blue),
      GlobalMenuModel(img: Images.subjectsIc, text: 'Subject', slug: 'subject', color: ColorRes.indigo),
      GlobalMenuModel(img: Images.timetableIc, text: 'Class Routine', slug: 'classRoutine', color: ColorRes.purple),
      GlobalMenuModel(img: Images.teacherIc, text: 'Teacher', slug: 'teacher', color: ColorRes.teal),
      GlobalMenuModel(img: Images.lessonIc, text: 'Lecture Sheet', slug: 'lectureSheet', color: ColorRes.greyBlue),
      // GlobalMenuModel(img: Images.assignmentIc, text: 'Assignment', slug: 'assignment', color: ColorRes.greyBlue),
      // GlobalMenuModel(img: Images.homeworkIc, text: 'Homework', slug: 'homework', color: ColorRes.greyBlue),
      GlobalMenuModel(img: Images.libraryIc, text: 'Library', slug: 'library', color: ColorRes.brown),
      GlobalMenuModel(img: Images.examScheduleIc, text: 'Exam Schedule', slug: 'examSchedule', color: ColorRes.brown),
      GlobalMenuModel(img: Images.markSheetIc, text: 'Exam Result', slug: 'examResult', color: ColorRes.green),
      // GlobalMenuModel(img: Images.leaveIc, text: 'Leave Application', slug: 'leaveApplication', color: ColorRes.red),
      GlobalMenuModel(img: Images.holeDayIc, text: 'Holy Day', slug: 'holyDay', color: ColorRes.green),
      GlobalMenuModel(img: Images.notificationIc, text: 'Notice', slug: 'notification', color: ColorRes.green),
    ];

  }


  String _getTimeBasedGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 5) {
      return "Good Late Night"; // Midnight - Dawn
    } else if (hour >= 5 && hour < 8) {
      return "Good Early Morning"; // Sunrise
    } else if (hour >= 8 && hour < 12) {
      return "Good Morning";
    } else if (hour == 12) {
      return "Good Noon"; // Exact midday
    } else if (hour > 12 && hour < 15) {
      return "Good Afternoon";
    } else if (hour >= 15 && hour < 17) {
      return "Good Late Afternoon";
    } else if (hour >= 17 && hour < 19) {
      return "Good Evening";
    } else if (hour >= 19 && hour < 22) {
      return "Good Night";
    } else {
      return "Good Late Night"; // 10 PM - Midnight
    }
  }

  IconData _getTimeBasedIcon() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 5) {
      return Icons.nights_stay; // 🌙 Late Night
    } else if (hour >= 5 && hour < 8) {
      return Icons.wb_twighlight; // 🌅 Early Morning
    } else if (hour >= 8 && hour < 12) {
      return Icons.wb_sunny; // ☀️ Morning
    } else if (hour == 12) {
      return Icons.brightness_high; // 🌞 Noon
    } else if (hour > 12 && hour < 15) {
      return Icons.wb_sunny_outlined; // ☀️ Afternoon
    } else if (hour >= 15 && hour < 17) {
      return Icons.wb_cloudy; // 🌤 Late Afternoon
    } else if (hour >= 17 && hour < 19) {
      return Icons.wb_twilight; // 🌇 Evening
    } else if (hour >= 19 && hour < 22) {
      return Icons.nightlight_round; // 🌙 Night
    } else {
      return Icons.bedtime; // 🛌 Late Night
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return GetBuilder<AuthController>(builder: (authController) {
        return CustomScrollViewWidget(
          scaffoldKey: drawerKey,
          drawer: StudentCustomDrawer(),
          sliverAppBar: SliverAppBarWidget(
            expandedHeight: 190,
            title: Container(
              width: size(context).width,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Column(
                children: [
                  // Top App Bar Section
                  Row(
                    children: [
                      // Modern Menu Button
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            (drawerKey.currentState?.isDrawerOpen ?? false)
                                ? drawerKey.currentState?.closeDrawer()
                                : drawerKey.currentState?.openDrawer();
                          },
                          child: Icon(
                            Icons.menu_rounded,
                            color: ColorRes.white,
                            size: 20,
                          ),
                        ),
                      ),

                      sizedBoxW(8),
                      // Title and Greeting Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalText(
                              str: "Student Dashboard",
                              color: ColorRes.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Icon(
                                    _getTimeBasedIcon(),
                                    color: ColorRes.white,
                                    size: 12,
                                  ),
                                ),

                                sizedBoxW(4),
                                GlobalText(
                                  str: _getTimeBasedGreeting(),
                                  color: ColorRes.white.withValues(alpha: 0.9),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Modern Notification Button
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => StudentNotificationScreen());
                          },
                          child: Stack(
                            children: [
                              const Icon(
                                Icons.notifications_outlined,
                                color: ColorRes.white,
                                size: 20,
                              ),
                              // Notification Badge (optional)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.red[400],
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: ColorRes.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isBackIc: false,
            flexibleSpace: StudentFlexibleSpaceBackWidget(
              child: StudentMenuBackgroundContainer(
                child: Column(
                  children: [
                    // Student Profile Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Student Name
                              GlobalText(
                                str: homePageController.studentProfileModel?.student?.name ?? 'Student Name',
                                color: ColorRes.appColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),

                              sizedBoxH(6),
                              // Class and Roll Info
                              Row(
                                children: [
                                  // Class Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorRes.appColor.withValues(alpha: 0.1),
                                          ColorRes.appColor.withValues(alpha: 0.05),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: ColorRes.appColor.withValues(alpha: 0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.school_outlined,
                                          size: 14,
                                          color: ColorRes.appColor,
                                        ),
                                        const SizedBox(width: 4),
                                        GlobalText(
                                          str: "Class ${homePageController.studentProfileModel?.studentDetail?.classData?.className ?? 'N/A'}",
                                          fontSize: 11,
                                          color: ColorRes.appColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Roll Number
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.badge_outlined,
                                          size: 14,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: GlobalText(
                                            str: "Roll: ${homePageController.studentProfileModel?.studentDetail?.roll ?? 'N/A'}",
                                            fontSize: 12,
                                            color: Colors.grey[600] ?? Colors.grey,
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
                        const SizedBox(width: 16),
                        // Profile Image with Modern Design
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                ColorRes.appColor.withValues(alpha: 0.1),
                                ColorRes.appColor.withValues(alpha: 0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: ColorRes.appColor.withValues(alpha: 0.2),
                              width: 0.5,
                            ),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: GlobalImageLoader(
                              imagePath: homePageController.studentProfileModel?.student?.photo ?? "",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              imageFor: ImageFor.network,
                              errorBuilder: (ctx, exception, stackTrace)=> GlobalImageLoader(
                                imagePath: Images.studentProfileIc,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // sizedBoxH(8),
                    // // Enhanced Attendance Section
                    // Container(
                    //   padding: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         ColorRes.appColor.withValues(alpha: 0.06),
                    //         ColorRes.appColor.withValues(alpha: 0.02),
                    //       ],
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.bottomRight,
                    //     ),
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(
                    //       color: ColorRes.appColor.withValues(alpha: 0.1),
                    //       width: 1,
                    //     ),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       // Attendance Header
                    //       Row(
                    //         children: [
                    //           Container(
                    //             padding: const EdgeInsets.all(5),
                    //             decoration: BoxDecoration(
                    //               color: ColorRes.appColor.withValues(alpha: 0.1),
                    //               borderRadius: BorderRadius.circular(4),
                    //             ),
                    //             child: Icon(
                    //               Icons.calendar_today_outlined,
                    //               color: ColorRes.appColor,
                    //               size: 12,
                    //             ),
                    //           ),
                    //           const SizedBox(width: 10),
                    //           GlobalText(
                    //             str: "Attendance Overview",
                    //             color: ColorRes.appColor,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //           const Spacer(),
                    //           Container(
                    //             padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                    //             decoration: BoxDecoration(
                    //               color: _getAttendanceColor(85).withValues(alpha: 0.15),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             child: GlobalText(
                    //               str: "85%",
                    //               fontSize: 11,
                    //               color: _getAttendanceColor(85),
                    //               fontWeight: FontWeight.w700,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //
                    //       const SizedBox(height: 10),
                    //
                    //       // Progress Bar
                    //       Container(
                    //         height: 5,
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey[200],
                    //           borderRadius: BorderRadius.circular(4),
                    //         ),
                    //         child: Stack(
                    //           children: [
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                 color: Colors.grey[200],
                    //                 borderRadius: BorderRadius.circular(4),
                    //               ),
                    //             ),
                    //             FractionallySizedBox(
                    //               alignment: Alignment.centerLeft,
                    //               widthFactor: 0.85, // 85% attendance
                    //               child: Container(
                    //                 decoration: BoxDecoration(
                    //                   gradient: LinearGradient(
                    //                     colors: [
                    //                       _getAttendanceColor(85),
                    //                       _getAttendanceColor(85).withValues(alpha: 0.8),
                    //                     ],
                    //                     begin: Alignment.centerLeft,
                    //                     end: Alignment.centerRight,
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(4),
                    //                   boxShadow: [
                    //                     BoxShadow(
                    //                       color: _getAttendanceColor(85).withValues(alpha: 0.3),
                    //                       blurRadius: 4,
                    //                       offset: const Offset(0, 2),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //
                    //       const SizedBox(height: 6),
                    //
                    //       // Attendance Stats
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           GlobalText(
                    //             str: "Present: 85 days",
                    //             fontSize: 11,
                    //             color: Colors.grey[600] ?? Colors.grey,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //           GlobalText(
                    //             str: "Total: 100 days",
                    //             fontSize: 11,
                    //             color: Colors.grey[600] ?? Colors.grey,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),

          slivers: [
            sliverSizedBoxH(10),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverToBoxAdapter(
                child: GlobalText(
                  str: 'Academics',
                  color: ColorRes.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                ),
              ),
            ),

            sliverSizedBoxH(5),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverGrid.builder(
                itemCount: menuItem?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 110
                ),
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () async {
                      switch (menuItem?[index].slug ?? "") {
                        case 'attendance':
                          Get.to(() => const StudentAttendanceScreen());
                          break;
                        case 'subject':
                          Get.to(() => const StudentSubjectScreen());
                          break;
                        case 'classRoutine':
                          Get.to(()=> const StudentClassRoutineScreen());
                          break;
                        case 'teacher':
                          Get.to(() => const StudentTeacherScreen());
                          break;
                        case 'lectureSheet':
                          Get.to(()=> const StudentLectureSheetScreen());
                          break;
                        case 'assignment':
                          Get.to(()=> const StudentAssignmentsScreen());
                          break;
                        case 'homework':
                          Get.to(()=> const StudentHomeworkScreen());
                          break;
                        case 'library':
                          Get.to(()=> const StudentLibraryBookListScreen());
                          break;
                        case 'examSchedule':
                          Get.to(()=> const StudentExamScheduleScreen());
                          break;
                        case 'examResult':
                          Get.to(()=> const StudentExamResultScreen());
                          break;
                        case 'leaveApplication':
                          Get.to(()=> const StudentLeaveScreen());
                          break;
                        case 'notification':
                          Get.to(()=> const StudentNotificationScreen());
                          break;
                        case 'holyDay':
                          Get.to(()=> const StudentHolyDayScreen());
                          break;

                          default:
                            showCustomSnackBar("The Menu is currently under development. Please use another menu");
                      }
                    },
                    child: StudentHomeMenuWidget(
                      height: 50,
                      width: 50,
                      maxLines: 2,
                      imagePath: menuItem?[index].img ?? "",
                      text: menuItem?[index].text ?? "",
                      color: menuItem?[index].color ?? Colors.indigo,
                    ),
                  );
                },
              ),
            ),

            sliverSizedBoxH(120),
          ],
        );
      });
    });
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 75) {
      return ColorRes.appColor;
    } else if (percentage >= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
