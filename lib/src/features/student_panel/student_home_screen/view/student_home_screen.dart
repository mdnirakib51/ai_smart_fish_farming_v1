
import 'package:ai_smart_fish_farming/src/global/widget/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/utils/show_toast.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/model.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../service/auth/controller/auth_controller.dart';
import '../../pond/pond_a_screen.dart';
import '../../student_attendance_screen/student_attendance_screen.dart';
import '../../student_class_routine/student_class_routine_screen.dart';
import '../../student_drawer/view/student_drawer_screen.dart';
import '../../student_notification_screen/student_notification_screen.dart';
import '../../student_subject_screen/student_subject_screen.dart';
import '../controller/student_home_controller.dart';

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
    super.initState();
    final studentHomeController = StudentHomePageController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentsProfileView();
      studentHomeController.getStudentsNotice();
    });

    menuItem = [
      GlobalMenuModel(
          img: Images.attendanceIc,
          text: 'Pond A',
          slug: 'pond_a',
          color: ColorRes.blue),
      GlobalMenuModel(
          img: Images.subjectsIc,
          text: 'Pond B',
          slug: 'pond_b',
          color: ColorRes.indigo),
      GlobalMenuModel(
          img: Images.timetableIc,
          text: 'Pond C',
          slug: 'pond_c',
          color: ColorRes.purple),
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
        return Scaffold(
          key: drawerKey,
          drawer: StudentCustomDrawer(),
          backgroundColor: Color(0xFFF5F5F5),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: GlobalAppBar(
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
                              Icons.waves_rounded,
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
                                str: "SmartFish",
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
                            child: Icon(
                              Icons.settings,
                              color: ColorRes.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              isBackIc: false,
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              // ChatBot action
              showCustomSnackBar("ChatBot feature coming soon!");
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              margin: EdgeInsets.only(bottom: 80),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorRes.appColor,
                    ColorRes.appColor.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: ColorRes.appColor.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chat_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  GlobalText(
                    str: "ChatBot",
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pond Cards
                ...List.generate(
                  menuItem?.length ?? 0,
                      (index) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () async {
                        switch (menuItem?[index].slug ?? "") {
                          case 'pond_a':
                            Get.to(() => const PondAScreen());
                            break;
                          case 'pond_b':
                            Get.to(() => const StudentSubjectScreen());
                            break;
                          case 'pond_c':
                            Get.to(() => const StudentClassRoutineScreen());
                            break;
                          default:
                            showCustomSnackBar(
                                "The Menu is currently under development. Please use another menu");
                        }
                      },
                      child: _buildPondCard(
                        context,
                        menuItem?[index].text ?? "",
                        menuItem?[index].img ?? "",
                        _getPondColor(index),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 100),
              ],
            ),
          ),
        );
      });
    });
  }

  Widget _buildPondCard(BuildContext context, String title, String imagePath, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorRes.appColor.withValues(alpha: 0.09),
            ColorRes.appColor.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorRes.appColor.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withValues(alpha: 0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: ColorRes.appColor.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorRes.appColor.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 8,
                  offset: Offset(-2, -2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: GlobalImageLoader(
              imagePath: imagePath,
              height: 36,
              width: 36,
              fit: BoxFit.contain,
              color: ColorRes.appColor,
            ),
          ),

          SizedBox(width: 18),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  str: title,
                  color: ColorRes.appColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4),
                GlobalText(
                  str: "View Details",
                  color: ColorRes.appColor.withValues(alpha: 0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),

          // Arrow Icon
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorRes.appColor.withValues(alpha: 0.15),
                  ColorRes.appColor.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorRes.appColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorRes.appColor,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPondColor(int index) {
    switch (index) {
      case 0:
        return Color(0xFF6366F1); // Indigo
      case 1:
        return Color(0xFF8B5CF6); // Purple
      case 2:
        return Color(0xFFEC4899); // Pink
      default:
        return ColorRes.appColor;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:get/get.dart';
// import 'package:ai_smart_fish_farming/src/global/utils/show_toast.dart';
// import '../../../../global/constants/colors_resources.dart';
// import '../../../../global/constants/enum.dart';
// import '../../../../global/constants/images.dart';
// import '../../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
// import '../../../../global/model.dart';
// import '../../../../global/widget/global_image_loader.dart';
// import '../../../../global/widget/global_sized_box.dart';
// import '../../../../global/widget/global_text.dart';
// import '../../../../service/auth/controller/auth_controller.dart';
// import '../../student_assignments_screen/student_assignments_screen.dart';
// import '../../student_attendance_screen/student_attendance_screen.dart';
// import '../../student_class_routine/student_class_routine_screen.dart';
// import '../../student_drawer/view/student_drawer_screen.dart';
// import '../../student_exam_result_screen/student_exam_result_screen.dart';
// import '../../student_exam_schedule_screen/student_exam_schedule_screen.dart';
// import '../../student_holy_day_screen/student_holy_day_screen.dart';
// import '../../student_homework_screen/student_homework_screen.dart';
// import '../../student_leave_screen/student_leave_screen.dart';
// import '../../student_lecture_sheet_screen/student_lecture_sheet_screen.dart';
// import '../../student_library_screen/student_library_book_list_screen.dart';
// import '../../student_notification_screen/student_notification_screen.dart';
// import '../../student_subject_screen/student_subject_screen.dart';
// import '../../student_teacher_screen/student_teacher_screen.dart';
// import '../../../widget/student_flexible_space_back_widget.dart';
// import '../../../widget/student_menu_background_container.dart';
// import '../controller/student_home_controller.dart';
// import 'widget/student_home_widget.dart';
//
// class StudentHomeScreen extends StatefulWidget {
//   const StudentHomeScreen({super.key});
//
//   @override
//   State<StudentHomeScreen> createState() => _StudentHomeScreenState();
// }
//
// class _StudentHomeScreenState extends State<StudentHomeScreen> {
//   final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
//
//   List<GlobalMenuModel>? menuItem;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final studentHomeController = StudentHomePageController.current;
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       studentHomeController.getStudentsProfileView();
//       studentHomeController.getStudentsNotice();
//     });
//
//     menuItem = [
//       GlobalMenuModel(img: Images.attendanceIc, text: 'Pond A', slug: 'pond_a', color: ColorRes.blue),
//       GlobalMenuModel(img: Images.subjectsIc, text: 'Pond B', slug: 'pond_b', color: ColorRes.indigo),
//       GlobalMenuModel(img: Images.timetableIc, text: 'Pond C', slug: 'pond_c', color: ColorRes.purple),
//     ];
//
//   }
//
//
//   String _getTimeBasedGreeting() {
//     DateTime now = DateTime.now();
//     int hour = now.hour;
//
//     if (hour >= 0 && hour < 5) {
//       return "Good Late Night"; // Midnight - Dawn
//     } else if (hour >= 5 && hour < 8) {
//       return "Good Early Morning"; // Sunrise
//     } else if (hour >= 8 && hour < 12) {
//       return "Good Morning";
//     } else if (hour == 12) {
//       return "Good Noon"; // Exact midday
//     } else if (hour > 12 && hour < 15) {
//       return "Good Afternoon";
//     } else if (hour >= 15 && hour < 17) {
//       return "Good Late Afternoon";
//     } else if (hour >= 17 && hour < 19) {
//       return "Good Evening";
//     } else if (hour >= 19 && hour < 22) {
//       return "Good Night";
//     } else {
//       return "Good Late Night"; // 10 PM - Midnight
//     }
//   }
//
//   IconData _getTimeBasedIcon() {
//     DateTime now = DateTime.now();
//     int hour = now.hour;
//
//     if (hour >= 0 && hour < 5) {
//       return Icons.nights_stay; // 🌙 Late Night
//     } else if (hour >= 5 && hour < 8) {
//       return Icons.wb_twighlight; // 🌅 Early Morning
//     } else if (hour >= 8 && hour < 12) {
//       return Icons.wb_sunny; // ☀️ Morning
//     } else if (hour == 12) {
//       return Icons.brightness_high; // 🌞 Noon
//     } else if (hour > 12 && hour < 15) {
//       return Icons.wb_sunny_outlined; // ☀️ Afternoon
//     } else if (hour >= 15 && hour < 17) {
//       return Icons.wb_cloudy; // 🌤 Late Afternoon
//     } else if (hour >= 17 && hour < 19) {
//       return Icons.wb_twilight; // 🌇 Evening
//     } else if (hour >= 19 && hour < 22) {
//       return Icons.nightlight_round; // 🌙 Night
//     } else {
//       return Icons.bedtime; // 🛌 Late Night
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StudentHomePageController>(builder: (homePageController) {
//       return GetBuilder<AuthController>(builder: (authController) {
//         return CustomScrollViewWidget(
//           scaffoldKey: drawerKey,
//           drawer: StudentCustomDrawer(),
//           sliverAppBar: SliverAppBarWidget(
//             expandedHeight: 65,
//             title: Container(
//               width: size(context).width,
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
//               child: Column(
//                 children: [
//                   // Top App Bar Section
//                   Row(
//                     children: [
//                       // Modern Menu Button
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha: 0.15),
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             color: Colors.white.withValues(alpha: 0.2),
//                             width: 1,
//                           ),
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             (drawerKey.currentState?.isDrawerOpen ?? false)
//                                 ? drawerKey.currentState?.closeDrawer()
//                                 : drawerKey.currentState?.openDrawer();
//                           },
//                           child: Icon(
//                             Icons.menu_rounded,
//                             color: ColorRes.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//
//                       sizedBoxW(8),
//                       // Title and Greeting Section
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             GlobalText(
//                               str: "Student Dashboard",
//                               color: ColorRes.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700,
//                               textAlign: TextAlign.left,
//                             ),
//                             const SizedBox(height: 2),
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(3),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withValues(alpha: 0.2),
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Icon(
//                                     _getTimeBasedIcon(),
//                                     color: ColorRes.white,
//                                     size: 12,
//                                   ),
//                                 ),
//
//                                 sizedBoxW(4),
//                                 GlobalText(
//                                   str: _getTimeBasedGreeting(),
//                                   color: ColorRes.white.withValues(alpha: 0.9),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500,
//                                   textAlign: TextAlign.left,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       // Modern Notification Button
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha: 0.15),
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             color: Colors.white.withValues(alpha: 0.2),
//                             width: 1,
//                           ),
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             Get.to(() => StudentNotificationScreen());
//                           },
//                           child: Stack(
//                             children: [
//                               const Icon(
//                                 Icons.notifications_outlined,
//                                 color: ColorRes.white,
//                                 size: 20,
//                               ),
//                               // Notification Badge (optional)
//                               Positioned(
//                                 right: 0,
//                                 top: 0,
//                                 child: Container(
//                                   width: 8,
//                                   height: 8,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red[400],
//                                     borderRadius: BorderRadius.circular(4),
//                                     border: Border.all(
//                                       color: ColorRes.white,
//                                       width: 1,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             isBackIc: false,
//           ),
//
//           slivers: [
//             sliverSizedBoxH(10),
//             SliverPadding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               sliver: SliverToBoxAdapter(
//                 child: GlobalText(
//                   str: 'Academics',
//                   color: ColorRes.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   textAlign: TextAlign.start,
//                 ),
//               ),
//             ),
//
//             sliverSizedBoxH(5),
//             SliverPadding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               sliver: SliverGrid.builder(
//                 itemCount: menuItem?.length ?? 0,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     mainAxisExtent: 110
//                 ),
//                 itemBuilder: (ctx, index) {
//                   return GestureDetector(
//                     onTap: () async {
//                       switch (menuItem?[index].slug ?? "") {
//                         case 'pond_a':
//                           Get.to(() => const StudentAttendanceScreen());
//                           break;
//                         case 'pond_b':
//                           Get.to(() => const StudentSubjectScreen());
//                           break;
//                         case 'pond_c':
//                           Get.to(()=> const StudentClassRoutineScreen());
//                           break;
//
//                           default:
//                             showCustomSnackBar("The Menu is currently under development. Please use another menu");
//                       }
//                     },
//                     child: StudentHomeMenuWidget(
//                       height: 50,
//                       width: 50,
//                       maxLines: 2,
//                       imagePath: menuItem?[index].img ?? "",
//                       text: menuItem?[index].text ?? "",
//                       color: menuItem?[index].color ?? Colors.indigo,
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             sliverSizedBoxH(120),
//           ],
//         );
//       });
//     });
//   }
//
//   Color _getAttendanceColor(double percentage) {
//     if (percentage >= 75) {
//       return ColorRes.appColor;
//     } else if (percentage >= 50) {
//       return Colors.orange;
//     } else {
//       return Colors.red;
//     }
//   }
// }
