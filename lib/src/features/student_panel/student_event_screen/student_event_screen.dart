import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'widget/event_detail_dialog.dart';
import 'widget/student_event_widget.dart';

class StudentEventScreen extends StatefulWidget {
  const StudentEventScreen({super.key});

  @override
  State<StudentEventScreen> createState() => _StudentEventScreenState();
}

class _StudentEventScreenState extends State<StudentEventScreen> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Academic', 'Sports', 'Cultural', 'Competitions', 'Workshops', 'Others'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Events",
          expandedHeight: 60,
        ),
        slivers: [
          sliverSizedBoxH(20),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      backgroundColor: ColorRes.white,
                      selectedColor: ColorRes.appColor,
                      checkmarkColor: ColorRes.white,
                      elevation: isSelected ? 2 : 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => selectedCategory = category);
                      },
                      label: GlobalText(
                        str: category,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return EventItemWidget(
                  title: "Annual Science Fair",
                  date: "Oct 25, 2023 • 9:00 AM",
                  location: "Science Building, Room 101",
                  category: "Academic",
                  registeredStudents: "250",
                  itemCount: index + 1,
                  onTap: () {
                    _showEventDetailsDialog(context, index);
                  },
                );
              },
            ),
          ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }

  void _showEventDetailsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => EventDetailDialog(
        title: "Annual Science Fair",
        date: "Oct 25, 2023 • 9:00 AM",
        location: "Science Building, Room 101",
        category: "Academic",
        registeredStudents: "250",
        description: "Showcasing student projects and experiments. All students are encouraged to participate and showcase their innovative ideas.",
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
// import '../student_home_screen/controller/parents_home_controller.dart';
// import 'widget/event_detail_dialog.dart';
// import 'widget/student_event_widget.dart';
//
// class StudentEventScreen extends StatefulWidget {
//   const StudentEventScreen({super.key});
//
//   @override
//   State<StudentEventScreen> createState() => _StudentEventScreenState();
// }
//
// class _StudentEventScreenState extends State<StudentEventScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StudentHomePageController>(builder: (homePageController) {
//       return CustomScrollViewWidget(
//         sliverAppBar: SliverAppBarWidget(
//           titleText: "Events",
//           expandedHeight: 60,
//         ),
//         slivers: [
//           sliverSizedBoxH(20),
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             sliver: SliverList.builder(
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return EventItemWidget(
//                   title: "Annual Science Fair",
//                   date: "Oct 25, 2023 • 9:00 AM",
//                   location: "Science Building, Room 101",
//                   category: "Academic",
//                   isFeatured: index == 0,
//                   itemCount: index + 1,
//                   onTap: () {
//                     _showEventDetailsDialog(context, index);
//                   },
//                 );
//               },
//             ),
//           ),
//           sliverSizedBoxH(20),
//         ],
//       );
//     });
//   }
//
//   void _showEventDetailsDialog(BuildContext context, int index) {
//     showDialog(
//       context: context,
//       builder: (context) => EventDetailDialog(
//         title: "Annual Science Fair",
//         date: "Oct 25, 2023 • 9:00 AM",
//         location: "Science Building, Room 101",
//         category: "Academic",
//         description: "Showcasing student projects and experiments. All students are encouraged to participate.",
//         isFeatured: index == 0,
//       ),
//     );
//   }
// }