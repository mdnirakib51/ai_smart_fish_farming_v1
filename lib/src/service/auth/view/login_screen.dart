import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_smart_fish_farming/src/global/constants/input_decoration.dart';
import 'package:ai_smart_fish_farming/src/service/auth/view/components/auth_background_com.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../features/student_panel/dashboard_bottom_navigation_bar/dashboard_bottom_navigation_bar.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_progress_hub.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_textform_field.dart';
import '../controller/auth_controller.dart';
import '../controller/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool history = true;
  // TextEditingController emailCon = TextEditingController(text: "md.rakib3248@gmail.com");
  // TextEditingController passCon = TextEditingController(text: "12345");
  TextEditingController emailCon = TextEditingController(text: "admin@gmail.com");
  TextEditingController passCon = TextEditingController(text: "12345");
  late bool _rememberMe;

  @override
  void initState() {
    super.initState();
    _rememberMe = false;
    _loadSavedCredentials();
  }

  void _saveCredentials() {
    AuthService.saveCredentials(
      email: emailCon.text,
      password: passCon.text,
      rememberMe: _rememberMe,
    );
  }

  void _loadSavedCredentials() {
    final credentials = AuthService.loadSavedCredentials();
    setState(() {
      emailCon.text = credentials['email'] ?? "";
      passCon.text = credentials['password'] ?? "";
      _rememberMe = credentials['remember_me'] ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: ProgressHUD(
            inAsyncCall: authController.isLoading,
            child: Form(
              key: formKey,
              child: AuthBackGroundCom(
                children: [

                  sizedBoxH(70),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: "Welcome",
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),

                        GlobalText(
                          str: "Please Log In to Continue",
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GlobalTextFormField(
                            controller: emailCon,
                            titleText: 'User Email / Unique ID / Phone',
                            hintText: 'Enter Your Email / Unique ID / Phone',
                            decoration: glassInputDecoration,
                            filled: true,
                            fillColor: ColorRes.white,
                            keyboardType: TextInputType.emailAddress,
                            titleStyle: GoogleFonts.roboto(
                                color: ColorRes.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700
                            ),
                            onChanged: (val){
                              setState(() {
                                _saveCredentials();
                              });
                            },
                          ),

                          sizedBoxH(20),
                          GlobalTextFormField(
                            controller: passCon,
                            titleText: 'Password',
                            hintText: 'Enter Your Password',
                            decoration: glassInputDecoration,
                            filled: true,
                            fillColor: ColorRes.white,
                            titleStyle: GoogleFonts.roboto(
                                color: ColorRes.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700
                            ),
                            isDense: true,
                            isPasswordField: true,
                            onChanged: (val){
                              setState(() {
                                _saveCredentials();
                              });
                            },
                          ),

                          sizedBoxH(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: ColorRes.appColor,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                      _saveCredentials();
                                    });
                                  },
                                ),
                              ),
                              sizedBoxW(10),
                              const GlobalText(
                                str: "Remember Me",
                                color: ColorRes.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              )
                            ],
                          ),

                          sizedBoxH(40),

                          // Login button (Purple matching 2nd image)
                          GlobalButtonWidget(
                              str: 'SIGN IN',
                              height: 45,
                              onTap: () async {
                                Get.offAll(() => DashboardBottomNavigationBar());
                                // authController.reqLogIn(
                                //     email: emailCon.text.trim(),
                                //     password: passCon.text.trim()
                                // );
                              }
                          ),

                          sizedBoxH(20),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SizedBox()
                  ),
                ],
              )
            ),
          )
      );
    });
  }
}

// Custom painter for top curved shape with orange accent
class TopCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    // Orange accent layer
    final orangePaint = Paint()
      ..color = Color(0xFFFFA726);

    final orangePath = Path();
    orangePath.moveTo(size.width * 0.1, 0);
    orangePath.lineTo(size.width, 0);
    orangePath.lineTo(size.width, size.height * 0.40);
    orangePath.quadraticBezierTo(
      size.width * 0.9, size.height * 0.8,
      size.width * 0.2, size.height * 0.8,
    );
    orangePath.quadraticBezierTo(
      size.width * 0.35, size.height * 0.65,
      size.width * 0.3, size.height * 0.5,
    );
    orangePath.close();

    canvas.drawPath(orangePath, orangePaint);

    // Purple background
    final purplePaint = Paint()
      ..color = ColorRes.appColor;

    final purplePath = Path();
    purplePath.moveTo(0, 0);
    purplePath.lineTo(size.width, 0);
    purplePath.lineTo(size.width, size.height * 0.3);
    purplePath.quadraticBezierTo(
      size.width * 0.7, size.height * 0.6,
      size.width * 0.3, size.height * 0.8,
    );
    purplePath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.85,
      0, size.height * 0.7,
    );
    purplePath.close();

    canvas.drawPath(purplePath, purplePaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for bottom curved shape with orange accent
class BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {


    // Orange accent layer
    final orangePaint = Paint()
      ..color = Color(0xFFFFA726);

    final orangePath = Path();
    orangePath.moveTo(0, size.height);
    orangePath.lineTo(size.width, size.height);
    orangePath.lineTo(size.width, size.height * 0.7);
    orangePath.quadraticBezierTo(
      size.width * 0.9, size.height * 0.1,
      size.width * 0.2, size.height * 0.7,
    );
    orangePath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.15,
      0, size.height * 0.1,
    );
    orangePath.close();

    canvas.drawPath(orangePath, orangePaint);

    // Purple background
    final purplePaint = Paint()
      ..color = ColorRes.appColor;

    final purplePath = Path();
    purplePath.moveTo(0, size.height);
    purplePath.lineTo(size.width, size.height);
    purplePath.lineTo(size.width, size.height * 0.9);
    purplePath.quadraticBezierTo(
      size.width * 0.5, size.height * 0.4,
      size.width * 0.8, size.height * 0.7,
    );
    purplePath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.12,
      0, size.height * 0.5,
    );
    purplePath.close();

    canvas.drawPath(purplePath, purplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   bool history = true;
//   TextEditingController emailCon = TextEditingController();
//   TextEditingController passCon = TextEditingController();
//   late bool _rememberMe;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _rememberMe = false;
//     _loadSavedCredentials();
//   }
//
//   Future<void> saveCredentials() async {
//     if (_rememberMe) {
//       locator<LocalStorage>().setString(key: StorageKeys.email, value: emailCon.text);
//       locator<LocalStorage>().setString(key: StorageKeys.password, value: passCon.text);
//     } else {
//       locator<LocalStorage>().remove(key: StorageKeys.email);
//       locator<LocalStorage>().remove(key: StorageKeys.password);
//     }
//     locator<LocalStorage>().setBool(key: StorageKeys.rememberMe, value: _rememberMe);
//   }
//
//   Future<void> _loadSavedCredentials() async {
//     final savedRememberMe = locator<LocalStorage>().getBool(key: StorageKeys.rememberMe, isFalse: false);
//
//     setState(() {
//       _rememberMe = savedRememberMe; // Use the value from SharedPreferences
//       if (_rememberMe) {
//         emailCon.text = locator<LocalStorage>().getString(key: StorageKeys.email) ?? "";
//         passCon.text = locator<LocalStorage>().getString(key: StorageKeys.password) ?? "";
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (authController) {
//       return Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: ProgressHUD(
//             inAsyncCall: authController.isLoading,
//             child: GlobalContainer(
//               height: size(context).height,
//               width: size(context).width,
//               color: Colors.white,
//               child: Form(
//                 key: formKey,
//                 child: Stack(
//                   children: [
//                     SizedBox(height: size(context).height, width: size(context).width),
//                     Container(
//                       height: size(context).height,
//                       width: size(context).width,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             ColorRes.black.withValues(alpha: 0.6),
//                             ColorRes.black.withValues(alpha: 0.4),
//                             ColorRes.black.withValues(alpha: 0.2),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     Positioned(
//                       left: 20,
//                       right: 20,
//                       top: size(context).height / 3,
//                       bottom: 20,
//                       child: Container(
//                         width: size(context).width,
//                         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: ColorRes.black.withValues(alpha: 0.3),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Column(
//                           children: [
//
//                             sizedBoxH(10),
//                             GlobalTextFormField(
//                               controller: emailCon,
//                               titleText: 'Email',
//                               hintText: 'Enter Your Email',
//                               titleStyle: GoogleFonts.roboto(
//                                   color: ColorRes.white,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w700
//                               ),
//                               filled: true,
//                               fillColor: ColorRes.white,
//                               decoration: todayDecoration,
//                               keyboardType: TextInputType.emailAddress,
//                               onChanged: (val){
//                                 setState(() {
//                                   saveCredentials();
//                                 });
//                               },
//                             ),
//
//                             sizedBoxH(15),
//                             GlobalTextFormField(
//                               controller: passCon,
//                               titleText: 'Password',
//                               hintText: 'Enter Your Password',
//                               titleStyle: GoogleFonts.roboto(
//                                   color: ColorRes.white,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w700
//                               ),
//                               filled: true,
//                               fillColor: ColorRes.white,
//                               decoration: todayDecoration,
//                               isDense: true,
//                               isPasswordField: true,
//                               onChanged: (val){
//                                 setState(() {
//                                   saveCredentials();
//                                 });
//                               },
//                             ),
//
//                             sizedBoxH(10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 18,
//                                   width: 18,
//                                   child: Checkbox(
//                                     activeColor: ColorRes.appColor,
//                                     value: _rememberMe,
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         _rememberMe = value ?? false;
//                                         saveCredentials();
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 sizedBoxW(10),
//                                 const GlobalText(
//                                   str: "Remember Me",
//                                   color: ColorRes.black,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 12,
//                                 )
//                               ],
//                             ),
//
//                             sizedBoxH(20),
//                             GlobalButtonWidget(
//                               str: 'SIGN IN',
//                               height: 45,
//                               buttomColor: ColorRes.appColor,
//                               onTap: () {
//                                 Get.to(()=> DashboardBottomNavigationBar());
//                               },
//                             ),
//
//                             sizedBoxH(10),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           )
//       );
//     });
//   }
// }
