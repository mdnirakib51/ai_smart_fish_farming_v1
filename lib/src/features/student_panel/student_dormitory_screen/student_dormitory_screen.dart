import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_text.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'student_dormitory_details_screen.dart';
import 'widget/student_dormitory_widget.dart';

class StudentDormitoryScreen extends StatefulWidget {
  const StudentDormitoryScreen({super.key});

  @override
  State<StudentDormitoryScreen> createState() => _StudentDormitoryScreenState();
}

class _StudentDormitoryScreenState extends State<StudentDormitoryScreen> {
  String selectedCategory = 'Students';
  final List<String> categories = ['All Blocks', 'Boys', 'Girls', 'Available'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Dormitory",
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          sliverSizedBoxH(20),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: ColorRes.appColor.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorRes.blue.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.home, color: ColorRes.blue, size: 24),
                          SizedBox(height: 8),
                          Text(
                            "4",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: ColorRes.blue,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Houses",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: ColorRes.appColor.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorRes.green.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.bed, color: ColorRes.green, size: 24),
                          SizedBox(height: 8),
                          Text(
                            "23",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: ColorRes.green,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Available",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: ColorRes.appColor.withValues(alpha: 0.2)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorRes.purple.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.star, color: ColorRes.purple, size: 24),
                          SizedBox(height: 8),
                          Text(
                            "4.7",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: ColorRes.purple,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Rating",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          sliverSizedBoxH(20),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return StudentDormitoryWidget(
                  houseName: "Abu Sayed Holl",
                  blockNumber: "Block A",
                  warden: "Md. Rafi Islam",
                  gender: "boys",
                  availableSpots: 22,
                  totalCapacity: 25,
                  rating: 4.8,
                  itemCount: index + 1,
                  onTap: () {
                    Get.to(() => StudentDormitoryDetailsScreen());
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
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../global/constants/colors_resources.dart';
// import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
// import '../../../global/widget/global_bottom_widget.dart';
// import '../../../global/widget/global_text.dart';
// import '../student_home_screen/controller/parents_home_controller.dart';
//
// class StudentDormitoryScreen extends StatefulWidget {
//   const StudentDormitoryScreen({super.key});
//
//   @override
//   State<StudentDormitoryScreen> createState() => _StudentDormitoryScreenState();
// }
//
// class _StudentDormitoryScreenState extends State<StudentDormitoryScreen> {
//
//   String selectedCategory = 'Students';
//   final List<String> categories = ['Students', 'Inspection', 'Payments', 'Contact'];
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StudentHomePageController>(builder: (homePageController) {
//       return CustomScrollViewWidget(
//         sliverAppBar: SliverAppBarWidget(
//           titleText: "Dormitory",
//           expandedHeight: 60,
//         ),
//         slivers: [
//           sliverSizedBoxH(20),
//           SliverToBoxAdapter(
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 20),
//               height: 50,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   final isSelected = selectedCategory == category;
//                   return Container(
//                     margin: const EdgeInsets.only(right: 12),
//                     child: FilterChip(
//                       backgroundColor: ColorRes.white,
//                       selectedColor: ColorRes.appColor,
//                       checkmarkColor: ColorRes.white,
//                       elevation: isSelected ? 2 : 0,
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       selected: isSelected,
//                       onSelected: (selected) {
//                         setState(() => selectedCategory = category);
//                       },
//                       label: GlobalText(
//                         str: category,
//                         color: isSelected ? Colors.white : Colors.grey.shade600,
//                         fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//
//           /// Timing Card
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: ColorRes.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: ColorRes.appColor.withValues(alpha:0.2),
//                     width: 1,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: ColorRes.black.withValues(alpha: 0.08),
//                       blurRadius: 15,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       const Icon(Icons.schedule, size: 40, color: ColorRes.appColor),
//                       const Text("Timing",
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 4),
//                       const Text("08:00 AM - 05:30 PM",
//                           style: TextStyle(color: Colors.black54)),
//                       const Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Row(children: [
//                             Icon(Icons.calendar_today, size: 16),
//                             SizedBox(width: 4),
//                             Text("Thu, 02 Mar")
//                           ]),
//                           Row(children: [
//                             Icon(Icons.access_time, size: 16),
//                             SizedBox(width: 4),
//                             Text("10:58 AM")
//                           ]),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child:  GlobalButtonWidget(
//                               str: 'Check In',
//                               textColor: ColorRes.white,
//                               borderColor: ColorRes.appColor,
//                               buttomColor: ColorRes.appColor,
//                               height: 45,
//                               onTap: () {
//                                 //Navigator.pop(context);
//                               },
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: GlobalButtonWidget(
//                               str: 'Check Out',
//                               textColor: ColorRes.appColor,
//                               borderColor: ColorRes.appColor,
//                               buttomColor: ColorRes.white,
//                               height: 45,
//                               onTap: () {
//                                 //Navigator.pop(context);
//                               },
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           const SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: GlobalText(
//                   str: "Dorm Rooms",
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 0),
//             sliver: SliverList.builder(
//               itemCount: 7,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: ColorRes.white,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(
//                         color: ColorRes.appColor.withValues(alpha:0.2),
//                         width: 1,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: ColorRes.black.withValues(alpha: 0.08),
//                           blurRadius: 15,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       title: GlobalText(
//                         str: "Female Dorm • Room",
//                         fontWeight: FontWeight.bold
//                       ),
//                       subtitle: GlobalText(
//                           str: "Slot: 4",
//                       ),
//                       trailing: Chip(
//                         label: GlobalText(
//                             str: "Available",
//                             color: ColorRes.green
//                         ),
//                         backgroundColor: Colors.green[50],
//                       ),
//                     ),
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
