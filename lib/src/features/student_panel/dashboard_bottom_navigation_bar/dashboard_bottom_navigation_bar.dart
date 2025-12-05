import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/confirm_alert_dialog.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import 'controller/dashboard_bottom_controller.dart';
import 'model/student_nav_item_model.dart';

class DashboardBottomNavigationBar extends StatefulWidget {
  const DashboardBottomNavigationBar({super.key});

  @override
  State<DashboardBottomNavigationBar> createState() => _DashboardBottomNavigationBarState();
}

class _DashboardBottomNavigationBarState extends State<DashboardBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardBottomController>(builder: (dashboardBottomController) {
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
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: size(context).width,
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1A2428),
                        Color(0xFF151C20),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)
                    ),
                    border: Border.all(
                      color: Color(0xFF2A3438),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        offset: const Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: ColorRes.appColor.withValues(alpha: 0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 15,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      studnetNavItemList.length,
                          (index) => Expanded(
                        child: GestureDetector(
                          onTap: () {
                            dashboardBottomController.onItemTapped(index);
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon Container
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: dashboardBottomController.selectedIndex == index
                                        ? LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        ColorRes.appColor,
                                        ColorRes.appColor.withValues(alpha: 0.8),
                                      ],
                                    )
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: dashboardBottomController.selectedIndex == index
                                        ? [
                                      BoxShadow(
                                        color: ColorRes.appColor.withValues(alpha: 0.3),
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ]
                                        : null,
                                  ),
                                  child: GlobalImageLoader(
                                    imagePath: studnetNavItemList[index].img,
                                    color: dashboardBottomController.selectedIndex == index
                                        ? ColorRes.white
                                        : Colors.white.withValues(alpha: 0.4),
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                sizedBoxH(6),
                                // Label Text
                                GlobalText(
                                  str: studnetNavItemList[index].title,
                                  fontSize: 10,
                                  color: dashboardBottomController.selectedIndex == index
                                      ? ColorRes.white
                                      : Colors.white.withValues(alpha: 0.5),
                                  fontWeight: dashboardBottomController.selectedIndex == index
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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