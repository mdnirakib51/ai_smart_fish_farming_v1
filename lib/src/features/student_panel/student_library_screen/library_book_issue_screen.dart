//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../global/constants/colors_resources.dart';
// import '../../../global/constants/input_decoration.dart';
// import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
// import '../../../global/widget/global_bottom_widget.dart';
// import '../../../global/widget/global_sized_box.dart';
// import '../../../global/widget/global_textform_field.dart';
// import '../student_home_screen/controller/student_home_controller.dart';
//
// class LibraryBookIssueScreen extends StatefulWidget {
//   const LibraryBookIssueScreen({super.key});
//
//   @override
//   State<LibraryBookIssueScreen> createState() => _LibraryBookIssueScreenState();
// }
//
// class _LibraryBookIssueScreenState extends State<LibraryBookIssueScreen> {
//   final TextEditingController bookIssueDateCon = TextEditingController();
//   final TextEditingController classCon = TextEditingController();
//   final TextEditingController rollCon = TextEditingController();
//   final TextEditingController sectionCon = TextEditingController();
//   final TextEditingController studentIdCon = TextEditingController();
//   final TextEditingController dueDateCon = TextEditingController();
//   final TextEditingController bookTitleCon = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StudentHomePageController>(builder: (homePageController) {
//       return CustomScrollViewWidget(
//         sliverAppBar: SliverAppBarWidget(
//           titleText: "Book Issue",
//           expandedHeight: 60,
//         ),
//         slivers: [
//           sliverSizedBoxH(20),
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   GlobalTextFormField(
//                     controller: bookIssueDateCon,
//                     labelText: 'Book Issue Date',
//                     hintText: 'Book Issue Date',
//                     sufixIcon: const Icon(Icons.calendar_month_outlined),
//                     suffixIconColor: ColorRes.deep300,
//                     decoration: borderDecoration,
//                     isDense: true,
//                     onChanged: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   sizedBoxH(15),
//                   GlobalTextFormField(
//                     controller: classCon,
//                     labelText: 'Class',
//                     hintText: 'Enter your Class',
//                     sufixIcon: const Icon(Icons.class_),
//                     suffixIconColor: ColorRes.deep300,
//                     decoration: borderDecoration,
//                     isDense: true,
//                     keyboardType: TextInputType.text,
//                     onChanged: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   sizedBoxH(15),
//                   GlobalTextFormField(
//                     controller: rollCon,
//                     labelText: 'Roll',
//                     hintText: 'Enter Your Roll',
//                     sufixIcon: const Icon(Icons.confirmation_number_outlined),
//                     suffixIconColor: ColorRes.deep300,
//                     decoration: borderDecoration,
//                     isDense: true,
//                     onChanged: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   sizedBoxH(15),
//                   GlobalTextFormField(
//                     controller: sectionCon,
//                     labelText: 'Section',
//                     hintText: 'Enter Your Section',
//                     sufixIcon: const Icon(Icons.segment),
//                     suffixIconColor: ColorRes.deep300,
//                     decoration: borderDecoration,
//                     isDense: true,
//                     onChanged: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   sizedBoxH(15),
//                   GlobalTextFormField(
//                     controller: studentIdCon,
//                     labelText: 'Student ID',
//                     hintText: 'Enter Your Student ID',
//                     sufixIcon: const Icon(Icons.badge_outlined),
//                     suffixIconColor: ColorRes.deep300,
//                     decoration: borderDecoration,
//                     isDense: true,
//                     onChanged: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   sizedBoxH(15),
//                   GlobalTextFormField(
//                     controller: bookTitleCon,
//                     labelText: 'Book Title',
//                     hintText: 'Enter Book Name',
//                     sufixIcon: const Icon(Icons.menu_book),
//                     suffixIconColor: ColorRes.deep300,
//                     decoration: borderDecoration,
//                     isDense: true,
//                     onChanged: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   sizedBoxH(15),
//                   GlobalTextFormField(
//                     controller: dueDateCon,
//                     labelText: 'Due Date',
//                     hintText: 'Due Date',
//                     sufixIcon: const Icon(Icons.date_range),
//                     suffixIconColor: ColorRes.deep300,
//                     decoration: borderDecoration,
//                     isDense: true,
//                     onChanged: (val) {
//                       setState(() {});
//                     },
//                   ),
//                   sizedBoxH(30),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: GlobalButtonWidget(
//                           str: 'Submit',
//                           height: 45,
//                           onTap: () {
//                             // TODO: Add update logic here
//                           },
//                         ),
//                       ),
//                       sizedBoxW(20),
//                       Expanded(
//                         child: GlobalButtonWidget(
//                           str: 'Back to List',
//                           buttomColor: ColorRes.white,
//                           textColor: ColorRes.appColor,
//                           borderColor: ColorRes.appColor,
//                           height: 45,
//                           onTap: () {
//                             // TODO: Add navigation logic here
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           sliverSizedBoxH(20),
//         ],
//       );
//     });
//   }
// }