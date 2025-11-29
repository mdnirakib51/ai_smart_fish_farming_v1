import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class StudentSubjectInfoWidget extends StatelessWidget {
  const StudentSubjectInfoWidget({
    super.key,
    required this.subject,
    required this.teacherName,
    this.color,
    this.itemCount,
  });

  final String subject;
  final String teacherName;
  final Color? color;
  final int? itemCount;

  static const List<Color> _colorList = [
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

  static const List<IconData> _subjectIcons = [
    Icons.language,
    Icons.translate,
    Icons.calculate,
    Icons.computer,
    Icons.public,
    Icons.science,
    Icons.menu_book,
    Icons.brush,
    Icons.agriculture,
  ];

  IconData _getSubjectIcon(String subjectName) {
    final lowerSubject = subjectName.toLowerCase();

    if (lowerSubject.contains('bangla')) return Icons.language;
    if (lowerSubject.contains('english')) return Icons.translate;
    if (lowerSubject.contains('math')) return Icons.calculate;
    if (lowerSubject.contains('ict') || lowerSubject.contains('computer')) return Icons.computer;
    if (lowerSubject.contains('bangladesh') || lowerSubject.contains('global')) return Icons.public;
    if (lowerSubject.contains('science')) return Icons.science;
    if (lowerSubject.contains('religion')) return Icons.menu_book;
    if (lowerSubject.contains('arts') || lowerSubject.contains('craft')) return Icons.brush;
    if (lowerSubject.contains('agriculture')) return Icons.agriculture;

    // Default icon based on index
    return itemCount != null ? _subjectIcons[(itemCount! - 1) % _subjectIcons.length] : Icons.book;
  }

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (itemCount != null ? _colorList[(itemCount! - 1) % _colorList.length] : ColorRes.appColor);
    final subjectIcon = _getSubjectIcon(subject);

    return StudentMenuTileContainer(
      color: color,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Subject Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: color.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                subjectIcon,
                color: color,
                size: 22,
              ),
            ),
            sizedBoxW(16),

            // Subject Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject Name
                  GlobalText(
                    str: subject,
                    fontWeight: FontWeight.bold,
                    color: ColorRes.black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  sizedBoxH(6),

                  // Teacher Info
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 14,
                        color: ColorRes.deep400,
                      ),
                      sizedBoxW(4),
                      Expanded(
                        child: GlobalText(
                          str: 'Teacher: $teacherName',
                          color: ColorRes.deep400,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}