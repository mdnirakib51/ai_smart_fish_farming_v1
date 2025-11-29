
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/constants/enum.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/confirm_alert_dialog.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_list_tile_widget.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../service/auth/controller/auth_service.dart';
import '../../student_attendance_screen/student_attendance_screen.dart';
import '../../student_class_routine/student_class_routine_screen.dart';
import '../../student_exam_result_screen/student_exam_result_screen.dart';
import '../../student_exam_schedule_screen/student_exam_schedule_screen.dart';
import '../../student_fee_screen/view/student_ledget_screen.dart';
import '../../student_help_support_screen/student_help_support_screen.dart';
import '../../student_home_screen/controller/student_home_controller.dart';
import '../../student_lecture_sheet_screen/student_lecture_sheet_screen.dart';
import '../../student_subject_screen/student_subject_screen.dart';
import 'student_change_password_screen.dart';

class StudentCustomDrawer extends StatefulWidget {
  const StudentCustomDrawer({super.key});

  @override
  State<StudentCustomDrawer> createState() => _StudentCustomDrawerState();
}

class _StudentCustomDrawerState extends State<StudentCustomDrawer> {

  int isDrop = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            sizedBoxH(60),
            GlobalImageLoader(
              imagePath: homePageController.studentProfileModel?.organization?.logo ?? "",
              height: 100,
              width: 100,
              fit: BoxFit.fill,
              imageFor: ImageFor.network,
            ),
            sizedBoxH(30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          width: Get.width,
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              // color: isClick == index ? ColorRes.shoesPrimaryColor : Colors.transparent,
                              color: ColorRes.appColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.home_rounded,
                                color: ColorRes.white,
                                size: 20,
                              ),
                              sizedBoxW(10),
                              const GlobalText(
                                str: "Dashboard",
                                color: ColorRes.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),

                      sizedBoxH(5),
                      GlobalListTile(
                        icon: Icons.assignment_outlined, // ✅ Attendance
                        title: 'Attendance',
                        onTap: () {
                          Get.to(() => StudentAttendanceScreen());
                        },
                      ),
                      GlobalListTile(
                        icon: Icons.schedule_outlined, // ✅ Class Routine
                        title: 'Class Routine',
                        onTap: () {
                          Get.to(() => StudentClassRoutineScreen());
                        },
                      ),
                      GlobalListTile(
                        icon: Icons.menu_book_outlined, // 📖 Lecture Sheet
                        title: 'Lecture Sheet',
                        onTap: () {
                          Get.to(() => StudentLectureSheetScreen());
                        },
                      ),
                      // GlobalListTile(
                      //   icon: Icons.local_library_outlined, // 📚 Library
                      //   title: 'Library',
                      //   onTap: () {
                      //     Get.to(() => StudentLibraryBookListScreen());
                      //   },
                      // ),
                      // GlobalListTile(
                      //   icon: Icons.book_outlined, // 📘 Syllabus
                      //   title: 'Syllabus',
                      //   onTap: () {
                      //     Get.to(() => StudentSyllabusScreen());
                      //   },
                      // ),
                      GlobalListTile(
                        icon: Icons.event_note_outlined, // 🗓️ Exam Schedule
                        title: 'Exam Schedule',
                        onTap: () {
                          Get.to(() => StudentExamScheduleScreen());
                        },
                      ),
                      GlobalListTile(
                        icon: Icons.grade_outlined, // 🏅 Exam Result
                        title: 'Exam Result',
                        onTap: () {
                          Get.to(() => StudentExamResultScreen());
                        },
                      ),
                      // GlobalListTile(
                      //   icon: Icons.event, // 🎉 Holy Day
                      //   title: 'Holy Day',
                      //   onTap: () {
                      //     Get.to(() => StudentHolyDayScreen());
                      //   },
                      // ),
                      // GlobalListTile(
                      //   icon: Icons.person_outline, // ✅ Teacher
                      //   title: 'Teacher',
                      //   onTap: () {
                      //     Get.to(() => StudentTeacherScreen());
                      //   },
                      // ),
                      GlobalListTile(
                        icon: Icons.menu_book_outlined, // ✅ Subjects
                        title: 'Subjects',
                        onTap: () {
                          Get.to(() => StudentSubjectScreen());
                        },
                      ),
                      GlobalListTile(
                        icon: Icons.receipt_long_outlined, // ✅ Payment Ledger
                        title: 'Payment Ledger',
                        onTap: () {
                          Get.to(() => StudentLedgerScreen());
                        },
                      ),

                      GlobalListTile(
                          icon: Icons.key,
                          title: 'Change Password',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx){
                                return StudentChangePasswordScreen();
                              },
                            );
                          }
                      ),
                      // GlobalListTile(
                      //     icon: Icons.settings_rounded,
                      //     title: 'Settings',
                      //     onTap: () {
                      //
                      //     }
                      // ),
                      GlobalListTile(
                          icon: Icons.help_rounded,
                          title: 'Help & Support',
                          onTap: () {
                            Get.to(() => StudentHelpSupportScreen());
                          }
                      ),
                      GlobalListTile(
                        icon: Icons.logout_rounded,
                        title: 'Logout',
                        onTap: () async{
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return ConfirmAlertDialog(
                                title: "Confirm Logout",
                                subTitle: "Are you sure you want to log out of your account?",
                                yesOnTap: () async {
                                  Navigator.pop(ctx); // Close dialog first
                                  await AuthService.performLogout();
                                },
                                noOnTap: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      ),

                      sizedBoxH(100)

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}