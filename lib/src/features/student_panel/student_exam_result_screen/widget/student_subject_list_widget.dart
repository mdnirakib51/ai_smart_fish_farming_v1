
import 'package:flutter/material.dart';
import '../../../../global/widget/text_widget.dart';

class StudentSubjectListWidget extends StatelessWidget {
  final int index;
  final String subject;
  final String score;
  final String grade;
  final String gpa;

  const StudentSubjectListWidget({
    super.key,
    required this.index,
    required this.subject,
    required this.score,
    required this.grade,
    required this.gpa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: TextWidget(str: '$index', fontWeight: FontWeight.w400)),
          Expanded(flex: 4, child: TextWidget(str: subject, textAlign: TextAlign.start, fontWeight: FontWeight.w400)),
          Expanded(flex: 2, child: TextWidget(str: score, fontWeight: FontWeight.w400)),
          Expanded(flex: 2, child: TextWidget(str: gpa, fontWeight: FontWeight.w400)),
          Expanded(flex: 2, child: TextWidget(str: grade, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}