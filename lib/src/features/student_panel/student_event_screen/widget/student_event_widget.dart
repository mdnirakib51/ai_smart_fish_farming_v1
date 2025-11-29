
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';


class EventItemWidget extends StatelessWidget {
  const EventItemWidget({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.category,
    required this.registeredStudents,
    this.color,
    required this.itemCount,
    required this.onTap,
  });
  final String title;
  final String date;
  final String location;
  final String category;
  final String registeredStudents;
  final Color? color;
  final int? itemCount;
  final VoidCallback onTap;

  static const List<Color> colorList = [
    ColorRes.blue,
    ColorRes.green,
    ColorRes.purple,
    ColorRes.red,
    ColorRes.indigo,
    ColorRes.orange,
    ColorRes.brown,
    ColorRes.greyBlue,
    ColorRes.darkGreen,
  ];

  IconData get _categoryIcon {
    switch (category) {
      case 'Academic':
        return Icons.school;
      case 'Sports':
        return Icons.sports;
      case 'Cultural':
        return Icons.palette;
      case 'Competitions':
        return Icons.emoji_events;
      case 'Workshops':
        return Icons.engineering;
      case 'Others':
        return Icons.event;
      default:
        return Icons.event;
    }
  }
  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (itemCount != null ? colorList[(itemCount! - 1) % colorList.length] : ColorRes.appColor);

    return StudentMenuTileContainer(
      color: color,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha:0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorRes.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha:0.05),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  border: Border(
                    bottom: BorderSide(
                      color: color.withValues(alpha:0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon( _categoryIcon, color: Colors.white, size: 24),
                    ),
                    sizedBoxW(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: title,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorRes.deep400,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        sizedBoxH(4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: GlobalText(
                            str: category.toUpperCase(),
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha:0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: color.withValues(alpha:0.2),
                            ),
                          ),
                          child: Icon(Icons.schedule, color: color, size: 16),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: 'DATE & TIME',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: ColorRes.grey,
                              ),
                              GlobalText(
                                str: date,
                                color: ColorRes.deep400,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBoxH(10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha:0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: color.withValues(alpha:0.2),
                            ),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: color,
                            size: 16,
                          ),
                        ),
                        sizedBoxW(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: 'VENUE',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: ColorRes.grey,
                              ),
                              GlobalText(
                                str: location,
                                color: ColorRes.deep400,
                                fontWeight: FontWeight.w600,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[200]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16,
                                  color: ColorRes.deep200,
                                ),
                                sizedBoxW(6),
                                GlobalText(
                                  str: '$registeredStudents Students',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorRes.deep200,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.grey[300],
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GlobalText(
                                  str: 'View Details',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                                sizedBoxW(4),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: color,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// class EventItemWidget extends StatelessWidget {
//   const EventItemWidget({
//     super.key,
//     required this.title,
//     required this.date,
//     required this.location,
//     required this.category,
//     required this.isFeatured,
//     this.color,
//     this.itemCount,
//     required this.onTap,
//   });
//   final String title;
//   final String date;
//   final String location;
//   final String category;
//   final bool isFeatured;
//   final Color? color;
//   final int? itemCount;
//   final VoidCallback onTap;
//
//   static const List<Color> colorList = [
//     ColorRes.blue,
//     ColorRes.green,
//     ColorRes.purple,
//     ColorRes.red,
//     ColorRes.indigo,
//     ColorRes.orange,
//     ColorRes.brown,
//     ColorRes.greyBlue,
//     ColorRes.darkGreen,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final color = this.color ?? (itemCount != null ? colorList[(itemCount! - 1) % colorList.length] : ColorRes.appColor);
//
//     return StudentMenuTileContainer(
//       color: color,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: ColorRes.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: ColorRes.black.withValues(alpha: 0.08),
//               blurRadius: 15,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(16),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: color,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: GlobalText(
//                         str: category,
//                         color: ColorRes.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     if (isFeatured)
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: ColorRes.orange,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: GlobalText(
//                           str: 'Featured',
//                           color: ColorRes.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                   ],
//                 ),
//                 sizedBoxH(12),
//                 GlobalText(
//                   str: title,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 sizedBoxH(8),
//                 Row(
//                   children: [
//                     const Icon(Icons.calendar_today, size: 16, color: ColorRes.grey),
//                     sizedBoxW(8),
//                     GlobalText(
//                       str: date,
//                       color: ColorRes.grey,
//                     ),
//                   ],
//                 ),
//                 sizedBoxH(4),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 16, color: ColorRes.grey),
//                     sizedBoxW(8),
//                     Expanded(
//                       child: GlobalText(
//                         str: location,
//                         color: ColorRes.grey,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }