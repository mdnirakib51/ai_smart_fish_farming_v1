
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../student_fee_screen/view/student_fee_screen.dart';
import '../../../student_panel/student_home_screen/view/student_home_screen.dart';
import '../../../student_panel/student_profile_screen/student_profile_screen.dart';
import '../../student_fee_screen/view/student_ledget_screen.dart';

class DashboardBottomController extends GetxController implements GetxService {
  static DashboardBottomController get current => Get.find();

  // ==/@ Navigation Bar
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  List<Widget> dashBoardBottomScreen = <Widget>[
    const StudentHomeScreen(),
    const StudentFeeScreen(),
    const StudentLedgerScreen(isBackIc: false),
    // const StudentHomeworkScreen(),
    const StudentProfileScreen(),
  ];

}
