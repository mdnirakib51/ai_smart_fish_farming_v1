import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/constants/enum.dart';
import 'package:ai_smart_fish_farming/src/global/utils/show_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../widget/student_menu_background_container.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../../widget/student_flexible_space_back_widget.dart';

class StudentTeacherScreen extends StatefulWidget {
  const StudentTeacherScreen({super.key});

  @override
  State<StudentTeacherScreen> createState() => _StudentTeacherScreenState();
}

class _StudentTeacherScreenState extends State<StudentTeacherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homePageController = Get.find<StudentHomePageController>();
      homePageController.getStudentClassTeacher();
    });
  }

  // Phone call function
  Future<void> _makePhoneCall(String phoneNumber) async {
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        showCustomSnackBar("Could not make phone call");
      }
    } catch (e) {
      showCustomSnackBar("Failed to make phone call: $e");
    }
  }

  // Email function
  Future<void> _sendEmail(String emailAddress) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: emailAddress);

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        showCustomSnackBar("Could not open email app");
      }
    } catch (e) {
      showCustomSnackBar("Failed to send email: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        inAsyncCall: homePageController.isLoading,
        sliverAppBar: SliverAppBarWidget(
          titleText: "Teachers",
          expandedHeight: 200,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
            child: homePageController.studentClassTeacherModel?.organization != null
                ? StudentMenuBackgroundContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    str: "School Information",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                  const SizedBox(height: 12),
                  if (homePageController.studentClassTeacherModel?.organization?.name != null)
                    Row(
                      children: [
                        Icon(Icons.school, size: 20, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            homePageController.studentClassTeacherModel!.organization!.name!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  if (homePageController.studentClassTeacherModel?.organization?.address != null)
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 20, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            homePageController.studentClassTeacherModel!.organization!.address!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            )
                : SizedBox.shrink(),
          ),
        ),
        slivers: [
          // Class Teacher Information
          if (homePageController.studentClassTeacherModel?.classTeacher != null)
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              sliver: SliverToBoxAdapter(
                child: StudentMenuBackgroundContainer(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Profile image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorRes.appColor.withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: GlobalImageLoader(
                                imagePath: homePageController.studentClassTeacherModel?.classTeacher?.photo ?? "",
                                fit: BoxFit.cover,
                                imageFor: ImageFor.network,
                              ),
                            ),
                          ),
                          sizedBoxW(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name
                                GlobalText(
                                  str: homePageController.studentClassTeacherModel?.classTeacher?.name ?? "No Name",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: ColorRes.deep400,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: ColorRes.appColor.withValues(alpha: 0.1),
                                  ),
                                  child: GlobalText(
                                    str: "Class Teacher",
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: ColorRes.appColor,
                                  ),
                                ),
                                sizedBoxH(5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_rounded,
                                      size: 16,
                                      color: ColorRes.grey,
                                    ),
                                    sizedBoxW(4),
                                    Expanded(
                                      child: GlobalText(
                                        str: "Class: ${homePageController.studentClassTeacherModel?.section?.className?.name ?? ''} - Section: ${homePageController.studentClassTeacherModel?.section?.name ?? ''}",
                                        fontSize: 13,
                                        color: ColorRes.grey,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      sizedBoxH(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: ColorRes.appColor.withValues(alpha: 0.1),
                                ),
                                child: Icon(
                                  Icons.phone_rounded,
                                  size: 18,
                                  color: ColorRes.appColor,
                                ),
                              ),
                              sizedBoxW(10),
                              Expanded(
                                child: GlobalText(
                                  str: homePageController.studentClassTeacherModel?.classTeacher?.phone ?? "No Phone",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          sizedBoxH(5),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: ColorRes.appColor.withValues(alpha: 0.1),
                                ),
                                child: Icon(
                                  Icons.email_rounded,
                                  size: 18,
                                  color: ColorRes.appColor,
                                ),
                              ),
                              sizedBoxW(10),
                              Expanded(
                                child: GlobalText(
                                  str: homePageController.studentClassTeacherModel?.classTeacher?.email ?? "No Email",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      sizedBoxH(10),
                      GlobalButtonWidget(
                        str: 'Contact Teacher',
                        textColor: ColorRes.appColor,
                        borderColor: ColorRes.appColor.withValues(alpha: 0.4),
                        buttomColor: ColorRes.white,
                        height: 40,
                        radius: 10,
                        onTap: () {
                          String? phoneNumber = homePageController.studentClassTeacherModel?.classTeacher?.phone;
                          if (phoneNumber != null && phoneNumber.isNotEmpty && phoneNumber != "No Phone") {
                            _makePhoneCall(phoneNumber);
                          } else {
                            showCustomSnackBar("Teacher phone number is not available");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // All Teachers Section Header
          if (homePageController.studentClassTeacherModel?.allTeachers != null &&
              homePageController.studentClassTeacherModel!.allTeachers!.isNotEmpty)
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              sliver: SliverToBoxAdapter(
                child: GlobalText(
                  str: "All Teachers",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.deep400,
                ),
              ),
            ),

          // All Teachers List
          if (homePageController.studentClassTeacherModel?.allTeachers != null &&
              homePageController.studentClassTeacherModel!.allTeachers!.isNotEmpty)
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverList.builder(
                itemCount: homePageController.studentClassTeacherModel!.allTeachers!.length,
                itemBuilder: (context, index) {
                  final teacher = homePageController.studentClassTeacherModel!.allTeachers![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: StudentMenuBackgroundContainer(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Profile image
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorRes.appColor.withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: GlobalImageLoader(
                                    imagePath: teacher.photo ?? "",
                                    fit: BoxFit.cover,
                                    imageFor: ImageFor.network,
                                  ),
                                ),
                              ),
                              sizedBoxW(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name
                                    GlobalText(
                                      str: teacher.name ?? "No Name",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: ColorRes.deep400,
                                    ),
                                    // Designation
                                    if (teacher.designation != null && teacher.designation!.isNotEmpty)
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: ColorRes.green.withValues(alpha: 0.1),
                                        ),
                                        child: GlobalText(
                                          str: teacher.designation!,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: ColorRes.green,
                                        ),
                                      ),
                                    sizedBoxH(4),
                                    // Subject
                                    if (teacher.subject != null && teacher.subject!.isNotEmpty)
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.menu_book,
                                            size: 14,
                                            color: ColorRes.grey,
                                          ),
                                          sizedBoxW(4),
                                          Expanded(
                                            child: GlobalText(
                                              str: teacher.subject!,
                                              fontSize: 12,
                                              color: ColorRes.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          sizedBoxH(12),
                          // Contact Information
                          Column(
                            children: [
                              // Phone
                              if (teacher.phone != null && teacher.phone!.isNotEmpty)
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: ColorRes.appColor.withValues(alpha: 0.1),
                                      ),
                                      child: Icon(
                                        Icons.phone_rounded,
                                        size: 16,
                                        color: ColorRes.appColor,
                                      ),
                                    ),
                                    sizedBoxW(8),
                                    Expanded(
                                      child: GlobalText(
                                        str: teacher.phone!,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              sizedBoxH(6),
                              // Email
                              if (teacher.email != null && teacher.email!.isNotEmpty)
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: ColorRes.appColor.withValues(alpha: 0.1),
                                      ),
                                      child: Icon(
                                        Icons.email_rounded,
                                        size: 16,
                                        color: ColorRes.appColor,
                                      ),
                                    ),
                                    sizedBoxW(8),
                                    Expanded(
                                      child: GlobalText(
                                        str: teacher.email!,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          sizedBoxH(10),
                          // Contact Buttons
                          Row(
                            children: [
                              // Call Button
                              if (teacher.phone != null && teacher.phone!.isNotEmpty)
                                Expanded(
                                  child: GlobalButtonWidget(
                                    str: 'Call',
                                    textColor: ColorRes.green,
                                    borderColor: ColorRes.green.withValues(alpha: 0.4),
                                    buttomColor: ColorRes.white,
                                    height: 35,
                                    radius: 8,
                                    onTap: () => _makePhoneCall(teacher.phone!),
                                  ),
                                ),
                              if (teacher.phone != null && teacher.phone!.isNotEmpty &&
                                  teacher.email != null && teacher.email!.isNotEmpty)
                                sizedBoxW(8),
                              // Email Button
                              if (teacher.email != null && teacher.email!.isNotEmpty)
                                Expanded(
                                  child: GlobalButtonWidget(
                                    str: 'Email',
                                    textColor: ColorRes.blue,
                                    borderColor: ColorRes.blue.withValues(alpha: 0.4),
                                    buttomColor: ColorRes.white,
                                    height: 35,
                                    radius: 8,
                                    onTap: () => _sendEmail(teacher.email!),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          // No data state
          if (homePageController.studentClassTeacherModel?.classTeacher == null &&
              (homePageController.studentClassTeacherModel?.allTeachers == null ||
                  homePageController.studentClassTeacherModel!.allTeachers!.isEmpty))
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Text(
                  "No Teachers Found",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    });
  }
}