
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/utils/show_toast.dart';
import '../../../global/widget/global_text.dart';

class PondADetailsScreen extends StatefulWidget {
  const PondADetailsScreen({super.key});

  @override
  State<PondADetailsScreen> createState() => _PondADetailsScreenState();
}

class _PondADetailsScreenState extends State<PondADetailsScreen> {
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
                str: "Analytics & Forecasting",
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
            // AI Forecasting Button
            GestureDetector(
              onTap: () {
                showCustomSnackBar("AI Forecasting feature coming soon!");
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0099FF),
                      Color(0xFF0077CC),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0099FF).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: GlobalText(
                    str: "AI Forecasting",
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Weekly PH Plot Forecast
            _buildForecastCard(
              title: "Weekly PH Plot Forecast",
              minValue: "6.0",
              maxValue: "7.6",
              days: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
              historicalData: [7.0, 7.1, 7.2, 7.0, 6.9, 7.0, 7.1],
              forecastData: [7.1, 7.2, 7.3, 7.4, 7.5],
              color: Color(0xFF0099FF),
            ),

            SizedBox(height: 16),

            // Weekly Mortality Rate Monitoring
            _buildForecastCard(
              title: "Weekly Mortality Rate Monitoring",
              minValue: "0",
              maxValue: "100",
              days: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
              historicalData: [90, 85, 80, 78, 75, 70, 65],
              forecastData: [60, 55, 50, 45, 40],
              color: Color(0xFF0099FF),
              showDecline: true,
            ),

            SizedBox(height: 16),

            // Weekly Feed Efficiency Plot
            _buildForecastCard(
              title: "Weekly Feed Efficiency Plot",
              minValue: "6.90",
              maxValue: "7.00",
              days: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
              historicalData: [6.92, 6.93, 6.94, 6.95, 6.96, 6.97, 6.98],
              forecastData: [6.99, 7.00, 7.01, 7.02, 7.03],
              color: Color(0xFF0099FF),
            ),

            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastCard({
    required String title,
    required String minValue,
    required String maxValue,
    required List<String> days,
    required List<double> historicalData,
    required List<double> forecastData,
    required Color color,
    bool showDecline = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
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
          GlobalText(
            str: title,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 140,
            child: Stack(
              children: [
                // Y-axis labels
                Positioned(
                  left: 0,
                  top: 0,
                  child: GlobalText(
                    str: maxValue,
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 70 - 5,
                  child: GlobalText(
                    str: ((double.parse(maxValue.replaceAll(RegExp(r'[^0-9.]'), '')) +
                        double.parse(minValue.replaceAll(RegExp(r'[^0-9.]'), ''))) / 2)
                        .toStringAsFixed(1),
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: GlobalText(
                    str: minValue,
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // Graph with grid lines
                Positioned.fill(
                  left: 30,
                  child: CustomPaint(
                    painter: ForecastGraphPainter(
                      historicalData: historicalData,
                      forecastData: forecastData,
                      minValue: double.parse(minValue.replaceAll(RegExp(r'[^0-9.]'), '')),
                      maxValue: double.parse(maxValue.replaceAll(RegExp(r'[^0-9.]'), '')),
                      color: color,
                      showDecline: showDecline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // X-axis labels (days)
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((day) => GlobalText(
                str: day,
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ForecastGraphPainter extends CustomPainter {
  final List<double> historicalData;
  final List<double> forecastData;
  final double minValue;
  final double maxValue;
  final Color color;
  final bool showDecline;

  ForecastGraphPainter({
    required this.historicalData,
    required this.forecastData,
    required this.minValue,
    required this.maxValue,
    required this.color,
    this.showDecline = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw horizontal grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int i = 0; i <= 4; i++) {
      final y = (size.height / 4) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final allData = [...historicalData, ...forecastData];
    final totalPoints = allData.length;
    final pointSpacing = size.width / (totalPoints - 1);

    // Historical area fill
    final historicalPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.4),
          color.withValues(alpha: 0.1),
          color.withValues(alpha: 0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final historicalLinePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final historicalPath = Path();
    final historicalLinePath = Path();

    // Draw historical data
    for (int i = 0; i < historicalData.length; i++) {
      final x = i * pointSpacing;
      final normalizedValue = (historicalData[i] - minValue) / (maxValue - minValue);
      final y = size.height - (normalizedValue * size.height);

      if (i == 0) {
        historicalPath.moveTo(x, size.height);
        historicalPath.lineTo(x, y);
        historicalLinePath.moveTo(x, y);
      } else {
        historicalLinePath.lineTo(x, y);
        historicalPath.lineTo(x, y);
      }
    }

    historicalPath.lineTo(
      (historicalData.length - 1) * pointSpacing,
      size.height,
    );
    historicalPath.close();

    canvas.drawPath(historicalPath, historicalPaint);
    canvas.drawPath(historicalLinePath, historicalLinePaint);

    // Forecast area fill
    final forecastPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF00C896).withValues(alpha: 0.4),
          Color(0xFF00C896).withValues(alpha: 0.1),
          Color(0xFF00C896).withValues(alpha: 0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final forecastLinePaint = Paint()
      ..color = Color(0xFF00C896)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final forecastPath = Path();
    final forecastLinePath = Path();

    final forecastStartIndex = historicalData.length - 1;

    for (int i = 0; i < forecastData.length; i++) {
      final x = (forecastStartIndex + i) * pointSpacing;
      final normalizedValue = (forecastData[i] - minValue) / (maxValue - minValue);
      final y = size.height - (normalizedValue * size.height);

      if (i == 0) {
        // Start from last historical point
        final lastHistX = forecastStartIndex * pointSpacing;
        final lastHistValue = (historicalData.last - minValue) / (maxValue - minValue);
        final lastHistY = size.height - (lastHistValue * size.height);

        forecastPath.moveTo(lastHistX, size.height);
        forecastPath.lineTo(lastHistX, lastHistY);
        forecastLinePath.moveTo(lastHistX, lastHistY);
        forecastLinePath.lineTo(x, y);
        forecastPath.lineTo(x, y);
      } else {
        forecastLinePath.lineTo(x, y);
        forecastPath.lineTo(x, y);
      }
    }

    forecastPath.lineTo(
      (forecastStartIndex + forecastData.length - 1) * pointSpacing,
      size.height,
    );
    forecastPath.close();

    canvas.drawPath(forecastPath, forecastPaint);
    canvas.drawPath(forecastLinePath, forecastLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}