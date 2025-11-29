
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/confirm_alert_dialog.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import 'controller/student_dashboard_bottom_controller.dart';
import 'model/student_nav_item_model.dart';

class DashboardBottomNavigationBar extends StatefulWidget {
  const DashboardBottomNavigationBar({super.key});

  @override
  State<DashboardBottomNavigationBar> createState() => _DashboardBottomNavigationBarState();
}

class _DashboardBottomNavigationBarState extends State<DashboardBottomNavigationBar> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentDashboardBottomController>(builder: (dashboardBottomController){
      return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (ctx) {
              return ConfirmAlertDialog(
                title: "Exit App",
                subTitle: "Are you sure you want to exit the app? All unsaved progress will be lost. Please confirm your action.",
                yesOnTap: () async {
                  Navigator.pop(ctx);
                  exit(0);
                },
                noOnTap: () {
                  Navigator.pop(ctx);
                },
              );
            },
          );
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              dashboardBottomController.dashBoardBottomScreen.elementAt(dashboardBottomController.selectedIndex),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  width: size(context).width,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(studnetNavItemList.length, (index) =>
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              dashboardBottomController.onItemTapped(index);
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GlobalImageLoader(
                                    imagePath: studnetNavItemList[index].img,
                                    color: dashboardBottomController.selectedIndex == index ? ColorRes.appColor : ColorRes.grey,
                                    height: 25,
                                    width: 25,
                                  ),
                                  sizedBoxH(5),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: dashboardBottomController.selectedIndex == index ? ColorRes.appColor : Colors.transparent,
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                    child: GlobalText(
                                      str: studnetNavItemList[index].title,
                                      fontSize: 9,
                                      color: dashboardBottomController.selectedIndex == index ? ColorRes.white : ColorRes.grey,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

  }
}

// late AnimationController _animationController;
// late Animation<double> _animation;
//
// @override
// void initState() {
//   super.initState();
//   _animationController = AnimationController(
//     duration: const Duration(milliseconds: 300),
//     vsync: this,
//   );
//   _animation = Tween<double>(begin: 0, end: 1).animate(
//     CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//   );
// }
//
// @override
// void dispose() {
//   _animationController.dispose();
//   super.dispose();
// }

// return GetBuilder<DashboardBottomController>(builder: (dashboardBottomController) {
//   return Scaffold(
//     resizeToAvoidBottomInset: false,
//     body: Stack(
//       children: [
//         dashboardBottomController.dashBoardBottomScreen.elementAt(dashboardBottomController.selectedIndex),
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: SizedBox(
//             height: 90,
//             child: Stack(
//               children: [
//                 // Main navigation bar
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     height: 70,
//                     margin: const EdgeInsets.only(top: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(25),
//                         topRight: Radius.circular(25),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withAlpha((0.1 * 255).toInt()), // Updated
//                           offset: const Offset(0, -2),
//                           blurRadius: 10,
//                           spreadRadius: 0,
//                         )
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: List.generate(navItemList.length, (index) {
//                         bool isSelected = dashboardBottomController.selectedIndex == index;
//                         return Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               dashboardBottomController.onItemTapped(index);
//                               if (isSelected) {
//                                 _animationController.forward().then((_) {
//                                   _animationController.reverse();
//                                 });
//                               }
//                             },
//                             child: SizedBox(
//                               height: 60,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   if (!isSelected) ...[
//                                     GlobalImageLoader(
//                                       imagePath: navItemList[index].img,
//                                       color: ColorRes.grey.withAlpha((0.6 * 255).toInt()), // Updated
//                                       height: 22,
//                                       width: 22,
//                                     ),
//                                     sizedBoxH(4),
//                                     GlobalText(
//                                       str: navItemList[index].title,
//                                       fontSize: 10,
//                                       color: ColorRes.grey.withAlpha((0.6 * 255).toInt()), // Updated
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ],
//                                   if (isSelected) ...[
//                                     sizedBoxH(25),
//                                     GlobalText(
//                                       str: navItemList[index].title,
//                                       fontSize: 11,
//                                       color: ColorRes.appColor,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ]
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//                 // Floating selected item
//                 AnimatedPositioned(
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                   left: (MediaQuery.of(context).size.width / navItemList.length) * dashboardBottomController.selectedIndex +
//                       (MediaQuery.of(context).size.width / navItemList.length - 50) / 2,
//                   top: 0,
//                   child: AnimatedBuilder(
//                     animation: _animation,
//                     builder: (context, child) {
//                       return Transform.scale(
//                         scale: 1.0 + (_animation.value * 0.1),
//                         child: Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: ColorRes.appColor,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: ColorRes.appColor.withAlpha((0.3 * 255).toInt()), // Updated
//                                 offset: const Offset(0, 4),
//                                 blurRadius: 15,
//                                 spreadRadius: 0,
//                               )
//                             ],
//                           ),
//                           child: Center(
//                             child: GlobalImageLoader(
//                               imagePath: navItemList[dashboardBottomController.selectedIndex].img,
//                               color: Colors.white,
//                               height: 24,
//                               width: 24,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// });