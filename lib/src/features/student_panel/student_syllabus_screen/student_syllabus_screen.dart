import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'widget/student_syllabus_widget.dart';

class StudentSyllabusScreen extends StatefulWidget {
  const StudentSyllabusScreen({super.key});

  @override
  State<StudentSyllabusScreen> createState() => _StudentSyllabusScreenState();
}

class _StudentSyllabusScreenState extends State<StudentSyllabusScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Syllabus",
          expandedHeight: 60,
        ),
        slivers: [
          sliverSizedBoxH(20),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.builder(
              itemCount: 11,
              itemBuilder: (context, index) {
                return StudentSyllabusWidget(
                  subject: "physics",
                  description: "The Class 9-10 Physics book explains basic concepts of motion, energy, heat, light, and electricity.",
                  imageUrl: "assets/dummy_img/book.jpg",
                  itemCount: index + 1,
                );
              },
            ),
          ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }
}