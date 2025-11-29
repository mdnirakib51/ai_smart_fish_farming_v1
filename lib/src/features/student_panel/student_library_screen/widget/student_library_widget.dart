import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class StudentLibraryWidget extends StatelessWidget {
  const StudentLibraryWidget({
    super.key,
    required this.bookName,
    required this.invoice,
    required this.issueDate,
    required this.returnDate,
    required this.status,
    required this.quantity,
    this.onTap,
  });

  final String bookName;
  final String invoice;
  final String issueDate;
  final String returnDate;
  final String status;
  final String quantity;
  final VoidCallback? onTap;

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

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'issued':
      case 'active':
        return Colors.green;
      case 'returned':
        return Colors.blue;
      case 'overdue':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = colorList[invoice.hashCode % colorList.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header with book info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  // Book icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: cardColor,
                      size: 24,
                    ),
                  ),
                  sizedBoxW(12),
                  // Book details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: bookName,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.deep400,
                          maxLines: 2,
                        ),
                        sizedBoxH(4),
                        GlobalText(
                          str: "Invoice: #$invoice",
                          fontSize: 12,
                          color: ColorRes.grey,
                        ),
                      ],
                    ),
                  ),
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: GlobalText(
                      str: status,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),

            // Details section
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Issue date
                  Expanded(
                    child: _buildInfoTile(
                      icon: Icons.calendar_today_outlined,
                      label: "Issue Date",
                      value: issueDate,
                      iconColor: Colors.blue,
                    ),
                  ),
                  sizedBoxW(8),
                  // Divider
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey.shade200,
                  ),
                  sizedBoxW(8),
                  // Return date
                  Expanded(
                    child: _buildInfoTile(
                      icon: Icons.event_available_outlined,
                      label: "Return Date",
                      value: returnDate,
                      iconColor: Colors.green,
                    ),
                  ),
                  sizedBoxW(8),
                  // Divider
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey.shade200,
                  ),
                  sizedBoxW(8),
                  // Quantity
                  Expanded(
                    child: _buildInfoTile(
                      icon: Icons.numbers_outlined,
                      label: "Quantity",
                      value: quantity,
                      iconColor: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
        sizedBoxH(4),
        GlobalText(
          str: label,
          fontSize: 10,
          color: ColorRes.grey,
          textAlign: TextAlign.center,
        ),
        sizedBoxH(2),
        GlobalText(
          str: value,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: ColorRes.deep400,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    );
  }
}