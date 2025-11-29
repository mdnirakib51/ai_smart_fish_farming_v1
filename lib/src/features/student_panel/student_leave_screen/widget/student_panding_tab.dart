import 'package:flutter/material.dart';
import 'student_leave_lsit_widget.dart';

class PendingTab extends StatelessWidget {
  final int selectedTab;

  const PendingTab({
    super.key,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: 9,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 100),
        itemBuilder: (ctx, index) {
          return LeaveListWidget(
            leaveReason: "Write Your Leave Reason",
            fromDate: "01/08/2025",
            toDate: "02/08/2025",
            day: "2",
            status: 'Pending',
            statusColor: 1,
          );
        },
      ),
    );
  }
}