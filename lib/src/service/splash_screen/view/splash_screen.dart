
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import '../../../domain/local/preferences/local_storage.dart';
import '../../../domain/local/preferences/local_storage_keys.dart';
import '../../../domain/local/preferences/storage_controller.dart';
import '../../../domain/server/http_client/app_config.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../../initializer.dart';
import '../../auth/view/login_screen.dart';
import '../../on_bording/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    route();
    checkForUpdate();

    // Reset to portrait mode when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  ///For In App Update ////
  Future<void> checkForUpdate() async {
    log('checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          log('update available');
          update();
        }
      });
    }).catchError((e) {
      log(e.toString());
    });
  }


  void update() async {
    log('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      log(e.toString());
    });
  }

  void route(){
    final storageController = LocalStorageController.current;
    Timer(const Duration(seconds: 3), () {
      final String? token = locator<LocalStorage>().getString(key: StorageKeys.accessToken);

      if(token == null){
        final String? savedBaseUrl = locator<LocalStorage>().getString(key: StorageKeys.baseUrl);

        if(savedBaseUrl == null || savedBaseUrl.isEmpty) {
          _showInstituteUrlDialog();
        } else {
          AppUrlExtention.setCustomUrl(savedBaseUrl);
          Get.offAll(() => const LoginScreen());
        }
      } else {
        Get.offAll(() => const LoginScreen());
      }
    });
  }

  void _showInstituteUrlDialog() {
    Get.offAll(()=> OnBoardingScreen(
      onUrlSubmitted: (String url) {
        locator<LocalStorage>().setString(key: StorageKeys.baseUrl, value: url);
        AppUrlExtention.setCustomUrl(url);

        Get.offAll(() => const LoginScreen());
      },
    ));
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (ctx) {
    //     return InstituteUrlDialog(
    //       onUrlSubmitted: (String url) {
    //         locator<LocalStorage>().setString(key: StorageKeys.baseUrl, value: url);
    //         AppUrlExtention.setCustomUrl(url);
    //
    //         Navigator.of(ctx).pop();
    //         Get.offAll(() => const LoginScreen());
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.appColor,
        body: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GlobalImageLoader(
                        imagePath: Images.appWhiteLogo,
                        height: 220,
                        width: 220,
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.code,
                      color: ColorRes.white,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    GlobalText(
                      str: "Developed By MinifyDev",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      color: Colors.white,
                    ),
                  ],
                ),

                sizedBoxH(30)
              ],
            ),
          ),
        )
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../domain/local/preferences/local_storage.dart';
// import '../../../domain/local/preferences/local_storage_keys.dart';
// import '../../../global/constants/images.dart';
// import '../../../global/widget/global_image_loader.dart';
// import '../../../global/widget/global_sized_box.dart';
// import '../../../initializer.dart';
// import '../../auth/view/login_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     route();
//
//     // Reset to portrait mode when exiting full-screen
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitUp,
//     ]);
//   }
//
//   void route(){
//     Timer(const Duration(seconds: 3), () {
//       final String? token = locator<LocalStorage>().getString(key: StorageKeys.accessToken);
//
//       if(token == null){
//         Get.offAll(()=> const LoginScreen());
//       } else{
//
//       }
//
//     });
//   }
//
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       height: size(context).height,
//       width: size(context).width,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF6467D8), Color(0xFFA47FF7)], // Purple Gradient
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const Spacer(),
//               // Illustration Placeholder
//               SizedBox(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     GlobalImageLoader(
//                       imagePath: Images.splashScreen,
//                       width: Get.width,
//                       fit: BoxFit.cover,
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               // Title
//               const Text(
//                 "Learning\ncan be fun!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               // Subtitle
//               const Text(
//                 "Homework is easy and simple!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white70,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               // Button with progress indicator
//               Container(
//                 height: 100,
//                 width: 100,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.white,
//                     width: 8,
//                   ),
//                   borderRadius: BorderRadius.circular(50),
//                   color: Colors.white.withValues(alpha: 0.02),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.white.withValues(alpha: 0.01),
//                       blurRadius: 4,
//                       offset: const Offset(2, 2),
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   height: 70,
//                   width: 70,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                   ),
//                   child: Center(
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_forward, size: 30),
//                       onPressed: () {
//                         Get.to(() => LoginScreen());
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
// }