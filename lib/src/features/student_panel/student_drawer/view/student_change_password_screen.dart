
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/input_decoration.dart';
import '../../../../global/utils/show_toast.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_dialog.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_textform_field.dart';
import '../../student_home_screen/controller/student_home_controller.dart';

class StudentChangePasswordScreen extends StatefulWidget {
  const StudentChangePasswordScreen({super.key});

  @override
  State<StudentChangePasswordScreen> createState() => _StudentChangePasswordScreenState();
}

class _StudentChangePasswordScreenState extends State<StudentChangePasswordScreen> {

  final TextEditingController passwordCon = TextEditingController();
  final TextEditingController confirmPasswordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return GlobalDialog(
        title: "Change Password",
        children: [
          sizedBoxH(10),
          GlobalTextFormField(
            controller: passwordCon,
            labelText: 'New Password (Optional)',
            hintText: 'Enter new password',
            decoration: borderDecoration.copyWith(
              fillColor: Colors.grey.shade50,
            ),
            isDense: true,
            isPasswordField: true,
            onChanged: (val) => setState(() {}),
          ),

          sizedBoxH(16),
          GlobalTextFormField(
            controller: confirmPasswordCon,
            labelText: 'Confirm Password',
            hintText: 'Re-enter new password',
            decoration: borderDecoration.copyWith(
              fillColor: Colors.grey.shade50,
            ),
            isDense: true,
            isPasswordField: true,
            onChanged: (val) => setState(() {}),
          ),

          sizedBoxH(20),
          GlobalButtonWidget(
              str: 'Change',
              height: 45,
              onTap: () async {
                if (passwordCon.text.isNotEmpty && passwordCon.text != confirmPasswordCon.text) {
                  showCustomSnackBar("Passwords do not match");
                  return;
                }
                homePageController.reqChangePassword(
                    confirmPassword: confirmPasswordCon.text.trim(),
                    onChange: (){
                      Navigator.pop(context);
                    }
                );
              }
          ),

          sizedBoxH(30),
        ],
      );
    });
  }
}
