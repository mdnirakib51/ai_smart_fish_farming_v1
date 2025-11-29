
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ai_smart_fish_farming/src/global/utils/show_toast.dart';
import 'package:ai_smart_fish_farming/src/global/widget/global_text.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/date_time_formatter.dart';
import '../../../global/constants/input_decoration.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/method/show_date_time_picker.dart';
import '../../../global/widget/buttomsheet_image_picker.dart';
import '../../../global/widget/global_compress_image.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_textform_field.dart';
import '../student_home_screen/controller/student_home_controller.dart';

class StudentProfileUpdateScreen extends StatefulWidget {
  const StudentProfileUpdateScreen({super.key});

  @override
  State<StudentProfileUpdateScreen> createState() => _StudentProfileUpdateScreenState();
}

class _StudentProfileUpdateScreenState extends State<StudentProfileUpdateScreen> {

  final TextEditingController userNameCon = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController phoneCon = TextEditingController();
  final TextEditingController bloodGroupCon = TextEditingController();
  final TextEditingController birthdateCon = TextEditingController();
  final TextEditingController fatherNameCon = TextEditingController();
  final TextEditingController motherNameCon = TextEditingController();
  final TextEditingController presentAddressCon = TextEditingController();
  final TextEditingController permanentAddressCon = TextEditingController();
  final TextEditingController houseNoCon = TextEditingController();
  final TextEditingController roadNoCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();
  final TextEditingController confirmPasswordCon = TextEditingController();

  XFile? selectedImage;
  String? selectedBloodGroup;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final List<String> bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  Future compressImageMain(XFile image) async {
    final compressedImage = await compressImageMb(image, 2);
    log("main image ${(await image.length()) / 1000000}");

    if (compressedImage != null) {
      log("compressed  ${(await compressedImage.length()) / 1000000}");
      log("compressed image ${(await compressedImage.length()) / 1000000}");

      setState(() {
        selectedImage = compressedImage;
      });
    } else {
      // showToast('Please pick another image!');
    }
  }

  @override
  void initState() {
    super.initState();
    final studentHomeController = StudentHomePageController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      studentHomeController.getStudentsProfileView().then((_) {
        _populateFields();
      });
    });
  }

  void _populateFields() {
    final controller = StudentHomePageController.current;
    final student = controller.studentProfileModel?.student;

    if (student != null) {
      userNameCon.text = student.name ?? '';
      emailCon.text = student.email ?? '';
      phoneCon.text = student.phone ?? '';
      bloodGroupCon.text = student.bloodGroup ?? '';
      selectedBloodGroup = student.bloodGroup;
      birthdateCon.text = student.birthdate ?? '';
      fatherNameCon.text = student.fatherName ?? '';
      motherNameCon.text = student.motherName ?? '';
      presentAddressCon.text = student.address ?? '';
      permanentAddressCon.text = student.permanentAddress ?? '';
      houseNoCon.text = student.houseNo ?? '';
      roadNoCon.text = student.roadNo ?? '';

      setState(() {});
    }
  }

  @override
  void dispose() {
    userNameCon.dispose();
    emailCon.dispose();
    phoneCon.dispose();
    bloodGroupCon.dispose();
    birthdateCon.dispose();
    fatherNameCon.dispose();
    motherNameCon.dispose();
    presentAddressCon.dispose();
    permanentAddressCon.dispose();
    houseNoCon.dispose();
    roadNoCon.dispose();
    passwordCon.dispose();
    confirmPasswordCon.dispose();
    super.dispose();
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorRes.grey.withValues(alpha: 0.3),
            blurRadius: 10,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorRes.appColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: ColorRes.appColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      width: 134,
      height: 134,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(67),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade100,
            Colors.grey.shade200,
          ],
        ),
      ),
      child: Icon(
        Icons.person_rounded,
        size: 60,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildBloodGroupDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: DropdownButtonFormField<String>(
        value: selectedBloodGroup,
        decoration: InputDecoration(
          labelText: 'Blood Group',
          hintText: 'Select your blood group',
          prefixIcon: Icon(
            Icons.bloodtype_rounded,
            color: ColorRes.deep300,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        items: bloodGroups.map((String bloodGroup) {
          return DropdownMenuItem<String>(
            value: bloodGroup,
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _getBloodGroupColor(bloodGroup).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      bloodGroup,
                      style: TextStyle(
                        color: _getBloodGroupColor(bloodGroup),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(bloodGroup),
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedBloodGroup = newValue;
            bloodGroupCon.text = newValue ?? '';
          });
        },
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black87),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: ColorRes.deep300,
        ),
      ),
    );
  }

  Color _getBloodGroupColor(String bloodGroup) {
    switch (bloodGroup) {
      case 'A+':
      case 'A-':
        return Colors.red.shade400;
      case 'B+':
      case 'B-':
        return Colors.blue.shade400;
      case 'AB+':
      case 'AB-':
        return Colors.purple.shade400;
      case 'O+':
      case 'O-':
        return Colors.green.shade400;
      default:
        return ColorRes.deep300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: CustomScrollViewWidget(
          sliverAppBar: SliverAppBarWidget(
            titleText: "Update Profile",
            expandedHeight: 60,
          ),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Profile Image Section
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    ColorRes.appColor.withValues(alpha: 0.1),
                                    ColorRes.appColor.withValues(alpha: 0.05),
                                  ],
                                ),
                                border: Border.all(
                                  color: selectedImage != null
                                      ? ColorRes.appColor.withValues(alpha: 0.3)
                                      : Colors.grey.shade300,
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(67),
                                child: selectedImage != null
                                    ? Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                  width: 134,
                                  height: 134,
                                )
                                    : GetBuilder<StudentHomePageController>(
                                  builder: (controller) {
                                    final student = controller.studentProfileModel?.student;
                                    return student?.photo != null && student!.photo!.isNotEmpty
                                        ? Image.network(
                                      student.photo!,
                                      fit: BoxFit.cover,
                                      width: 134,
                                      height: 134,
                                      errorBuilder: (context, error, stackTrace) {
                                        return _buildDefaultAvatar();
                                      },
                                    )
                                        : _buildDefaultAvatar();
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  final file = await showModalBottomSheet<XFile?>(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return const BottomSheetImagePicker();
                                      });
                                  if (file != null) {
                                    await compressImageMain(XFile(file.path));
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: ColorRes.appColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorRes.appColor.withValues(alpha: 0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH(16),
                        GlobalText(
                          str: "Profile Picture",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                        sizedBoxH(4),
                        GlobalText(
                          str: "Tap the camera icon to update",
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ],
                    ),

                    sizedBoxH(10),

                    // Personal Information Section
                    _buildSectionCard(
                      title: "Personal Information",
                      icon: Icons.person_rounded,
                      children: [
                        GlobalTextFormField(
                          controller: userNameCon,
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          sufixIcon: const Icon(Icons.person_outline_rounded),
                          suffixIconColor: ColorRes.deep300,
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          onChanged: (val) => setState(() {}),
                        ),
                        sizedBoxH(16),
                        GlobalTextFormField(
                          controller: emailCon,
                          labelText: 'Email Address',
                          hintText: 'Enter your email address',
                          sufixIcon: const Icon(Icons.email_outlined),
                          suffixIconColor: ColorRes.deep300,
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) => setState(() {}),
                        ),
                        sizedBoxH(16),
                        GlobalTextFormField(
                          controller: phoneCon,
                          labelText: 'Phone Number',
                          hintText: 'Enter your phone number',
                          sufixIcon: const Icon(Icons.phone_outlined),
                          suffixIconColor: ColorRes.deep300,
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          keyboardType: TextInputType.phone,
                          onChanged: (val) => setState(() {}),
                        ),
                        sizedBoxH(16),
                        _buildBloodGroupDropdown(),
                        sizedBoxH(16),
                        GlobalTextFormField(
                          controller: birthdateCon,
                          labelText: 'Date of Birth',
                          hintText: 'Select your birth date',
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          readOnly: true,
                          sufixIcon: GestureDetector(
                            onTap: () async {
                              var pickedDate = await showDateOnlyPicker(context);
                              setState(() {
                                String formatedDate = DateTimeFormatter.showDateOnlyYear.format(pickedDate);
                                birthdateCon.text = formatedDate;
                              });
                            },
                            child: const Icon(
                              Icons.calendar_today_rounded,
                              color: ColorRes.deep300,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Family Information Section
                    _buildSectionCard(
                      title: "Family Information",
                      icon: Icons.family_restroom_rounded,
                      children: [
                        GlobalTextFormField(
                          controller: fatherNameCon,
                          labelText: 'Father\'s Name',
                          hintText: 'Enter father\'s name',
                          sufixIcon: const Icon(Icons.person_outline_rounded),
                          suffixIconColor: ColorRes.deep300,
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          onChanged: (val) => setState(() {}),
                        ),
                        sizedBoxH(16),
                        GlobalTextFormField(
                          controller: motherNameCon,
                          labelText: 'Mother\'s Name',
                          hintText: 'Enter mother\'s name',
                          sufixIcon: const Icon(Icons.person_outline_rounded),
                          suffixIconColor: ColorRes.deep300,
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          onChanged: (val) => setState(() {}),
                        ),
                      ],
                    ),

                    // Address Information Section
                    _buildSectionCard(
                      title: "Address Information",
                      icon: Icons.location_on_rounded,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GlobalTextFormField(
                                controller: houseNoCon,
                                labelText: 'House No',
                                hintText: 'House number',
                                sufixIcon: const Icon(Icons.home_outlined),
                                suffixIconColor: ColorRes.deep300,
                                decoration: borderDecoration.copyWith(
                                  fillColor: Colors.grey.shade50,
                                ),
                                isDense: true,
                                onChanged: (val) => setState(() {}),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GlobalTextFormField(
                                controller: roadNoCon,
                                labelText: 'Road No',
                                hintText: 'Road number',
                                sufixIcon: const Icon(Icons.add_road_rounded),
                                suffixIconColor: ColorRes.deep300,
                                decoration: borderDecoration.copyWith(
                                  fillColor: Colors.grey.shade50,
                                ),
                                isDense: true,
                                onChanged: (val) => setState(() {}),
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH(16),
                        GlobalTextFormField(
                          controller: presentAddressCon,
                          labelText: 'Present Address',
                          hintText: 'Enter your present address',
                          sufixIcon: const Icon(Icons.location_city_rounded),
                          suffixIconColor: ColorRes.deep300,
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          maxLines: 2,
                          onChanged: (val) => setState(() {}),
                        ),
                        sizedBoxH(16),
                        GlobalTextFormField(
                          controller: permanentAddressCon,
                          labelText: 'Permanent Address',
                          hintText: 'Enter your permanent address',
                          sufixIcon: const Icon(Icons.home_work_rounded),
                          suffixIconColor: ColorRes.deep300,
                          decoration: borderDecoration.copyWith(
                            fillColor: Colors.grey.shade50,
                          ),
                          isDense: true,
                          maxLines: 2,
                          onChanged: (val) => setState(() {}),
                        ),
                      ],
                    ),

                    // Security Section
                    // _buildSectionCard(
                    //   title: "Security Settings",
                    //   icon: Icons.security_rounded,
                    //   children: [
                    //     GlobalTextFormField(
                    //       controller: passwordCon,
                    //       labelText: 'New Password (Optional)',
                    //       hintText: 'Enter new password',
                    //       sufixIcon: GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             _passwordVisible = !_passwordVisible;
                    //           });
                    //         },
                    //         child: Icon(
                    //           _passwordVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                    //           color: ColorRes.deep300,
                    //         ),
                    //       ),
                    //       decoration: borderDecoration.copyWith(
                    //         fillColor: Colors.grey.shade50,
                    //       ),
                    //       isDense: true,
                    //       obscureText: !_passwordVisible,
                    //       onChanged: (val) => setState(() {}),
                    //     ),
                    //     sizedBoxH(16),
                    //     GlobalTextFormField(
                    //       controller: confirmPasswordCon,
                    //       labelText: 'Confirm Password',
                    //       hintText: 'Re-enter new password',
                    //       sufixIcon: GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             _confirmPasswordVisible = !_confirmPasswordVisible;
                    //           });
                    //         },
                    //         child: Icon(
                    //           _confirmPasswordVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                    //           color: ColorRes.deep300,
                    //         ),
                    //       ),
                    //       decoration: borderDecoration.copyWith(
                    //         fillColor: Colors.grey.shade50,
                    //       ),
                    //       isDense: true,
                    //       obscureText: !_confirmPasswordVisible,
                    //       onChanged: (val) => setState(() {}),
                    //     ),
                    //   ],
                    // ),

                    // Update Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: homePageController.isLoading
                              ? [Colors.grey.shade400, Colors.grey.shade400]
                              : [ColorRes.appColor, ColorRes.appColor.withValues(alpha: 0.8)],
                        ),
                        boxShadow: homePageController.isLoading
                            ? []
                            : [
                          BoxShadow(
                            color: ColorRes.appColor.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: homePageController.isLoading
                              ? null
                              : () {
                            if (userNameCon.text.trim().isEmpty) {
                              Get.snackbar(
                                'Error',
                                'Name is required',
                                backgroundColor: Colors.red.shade100,
                                colorText: Colors.red.shade800,
                              );
                              return;
                            }
                            if (emailCon.text.trim().isEmpty) {
                              Get.snackbar(
                                'Error',
                                'Email is required',
                                backgroundColor: Colors.red.shade100,
                                colorText: Colors.red.shade800,
                              );
                              return;
                            }

                            if (passwordCon.text.isNotEmpty && passwordCon.text != confirmPasswordCon.text) {
                              showCustomSnackBar("Passwords do not match");
                              return;
                            }

                            homePageController.reqUpdateProfile(
                              name: userNameCon.text.trim(),
                              email: emailCon.text.trim(),
                              phone: phoneCon.text.trim(),
                              bloodGroup: bloodGroupCon.text.trim(),
                              birthdate: birthdateCon.text.trim(),
                              fatherName: fatherNameCon.text.trim(),
                              motherName: motherNameCon.text.trim(),
                              address: presentAddressCon.text.trim(),
                              permanentAddress: permanentAddressCon.text.trim(),
                              houseNo: houseNoCon.text.trim(),
                              roadNo: roadNoCon.text.trim(),
                              password: passwordCon.text.isNotEmpty ? passwordCon.text : null,
                              imagePath: selectedImage,
                            );
                          },
                          child: Center(
                            child: homePageController.isLoading
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Updating...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                                : const Text(
                              'Update Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    sizedBoxH(30),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}