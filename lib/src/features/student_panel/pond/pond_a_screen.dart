import 'package:ai_smart_fish_farming/src/global/widget/global_appbar.dart';
import 'package:ai_smart_fish_farming/src/global/widget/global_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/utils/show_toast.dart';
import '../../../global/widget/global_text.dart';
import 'pond_a_details_screen.dart';

class PondAScreen extends StatefulWidget {
  const PondAScreen({super.key});

  @override
  State<PondAScreen> createState() => _PondAScreenState();
}

class _PondAScreenState extends State<PondAScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.appColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          color: ColorRes.appColor,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A2428),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(width: 16),
              GlobalText(
                str: "Pond Details - Pond A",
                color: ColorRes.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showCustomSnackBar("AI ChatBot feature coming soon!");
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0099FF),
                Color(0xFF0066CC),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF0099FF).withValues(alpha: 0.4),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 22,
              ),
              SizedBox(width: 10),
              GlobalText(
                str: "AI ChatBot",
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Weather Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3B9FD9),
                    Color(0xFF2B7FB5),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    color: Color(0xFFFDB813),
                    size: 60,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: "28°C",
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 4),
                        GlobalText(
                          str: "Sunny",
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        GlobalText(
                          str: "Rajshahi",
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Header Text
            sizedBoxH(20),
            GlobalText(
              str: "Real-time sensor data",
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.left,
            ),

            sizedBoxH(10),
            // First Row - PH Level & TDS
            Row(
              children: [
                Expanded(
                  child: _buildSensorCard(
                    title: "PH Level",
                    value: "7.2",
                    status: "(Optimal)",
                    statusColor: Color(0xFF00C896),
                    graphColor: Color(0xFF00C896),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildSensorCard(
                    title: "TDS",
                    value: "4.3",
                    status: "(Optimal)",
                    statusColor: Color(0xFF00C896),
                    graphColor: Color(0xFF0099FF),
                    onTap: () {
                      Get.to(() => PondADetailsScreen());
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Second Row - DO Level & Temp
            Row(
              children: [
                Expanded(
                  child: _buildSensorCard(
                    title: "DO Level",
                    value: "7.2",
                    status: "(Optimal)",
                    statusColor: Color(0xFF00C896),
                    graphColor: Color(0xFF00C896),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildSensorCard(
                    title: "Temp",
                    value: "28°C",
                    status: "(Optimal)",
                    statusColor: Color(0xFFFF9F43),
                    graphColor: Color(0xFF0099FF),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Third Row - Turbidity & Ammonia
            Row(
              children: [
                Expanded(
                  child: _buildSensorCard(
                    title: "Turbidity",
                    value: "7.2",
                    status: "(Optimal)",
                    statusColor: Color(0xFF00C896),
                    graphColor: Color(0xFF00C896),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildSensorCard(
                    title: "Ammonia",
                    value: "0.2",
                    status: "(Optimal)",
                    statusColor: Color(0xFF00C896),
                    graphColor: Color(0xFF0099FF),
                  ),
                ),
              ],
            ),

            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard({
    required String title,
    required String value,
    required String status,
    required Color statusColor,
    required Color graphColor,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF1A2428),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFF2A3438),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalText(
                  str: title,
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color: statusColor,
                    size: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            GlobalText(
              str: value,
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 4),
            GlobalText(
              str: status,
              color: statusColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              child: CustomPaint(
                painter: SensorGraphPainter(color: graphColor),
                size: Size.infinite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SensorGraphPainter extends CustomPainter {
  final Color color;

  SensorGraphPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    final linePath = Path();

    // Create smooth wave pattern
    final points = [0.7, 0.4, 0.5, 0.3, 0.45, 0.35, 0.4, 0.3, 0.2, 0.15];

    path.moveTo(0, size.height);
    linePath.moveTo(0, size.height * points[0]);

    for (int i = 0; i < points.length; i++) {
      final x = (size.width / (points.length - 1)) * i;
      final y = size.height * points[i];

      if (i == 0) {
        path.lineTo(x, y);
        linePath.lineTo(x, y);
      } else {
        // Create smooth curves
        final prevX = (size.width / (points.length - 1)) * (i - 1);
        final prevY = size.height * points[i - 1];
        final cpX = (prevX + x) / 2;

        path.quadraticBezierTo(cpX, prevY, x, y);
        linePath.quadraticBezierTo(cpX, prevY, x, y);
      }
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}