// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
// import '../../../global/model.dart';
// import '../student_home_screen/controller/student_home_controller.dart';
// import '../student_home_screen/view/widget/student_home_widget.dart';
// import 'library_book_issue_screen.dart';
// import 'student_library_book_list_screen.dart';
//
// class StudentLibraryScreen extends StatefulWidget {
//   const StudentLibraryScreen({super.key});
//
//   @override
//   State<StudentLibraryScreen> createState() => _StudentLibraryScreenState();
// }
//
// class _StudentLibraryScreenState extends State<StudentLibraryScreen> {
//
//   List<GlobalMenuModel>? menuItem;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // menuItem = [
//     //   GlobalMenuModel(img: Images.libraryIc, text: 'Book Issue', color: ColorRes.darkGreen),
//     //   GlobalMenuModel(img: Images.libraryIc, text: 'Book List', color: ColorRes.blue),
//     // ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StudentHomePageController>(builder: (homePageController) {
//       return CustomScrollViewWidget(
//         sliverAppBar: SliverAppBarWidget(
//           titleText: "Library",
//           expandedHeight: 60,
//         ),
//         slivers: [
//           sliverSizedBoxH(20),
//
//           SliverPadding(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             sliver: SliverGrid.builder(
//               itemCount: menuItem?.length ?? 0,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   mainAxisExtent: 150
//               ),
//               itemBuilder: (ctx, index) {
//                 return GestureDetector(
//                   onTap: () async {
//                     switch (index) {
//                       case 0:
//                         Get.to(() => const LibraryBookIssueScreen());
//                         break;
//                       case 1:
//                         Get.to(() => const StudentLibraryBookListScreen());
//                         break;
//                     }
//                   },
//                   child: StudentHomeMenuWidget(
//                     height: 40,
//                     width: 40,
//                     maxLines: 2,
//                     imagePath: menuItem?[index].img ?? "",
//                     text: menuItem?[index].text ?? "",
//                     color: menuItem?[index].color ?? Colors.indigo,
//                   ),
//                 );
//               },
//             ),
//           ),
//           sliverSizedBoxH(20),
//         ],
//       );
//     });
//   }
// }