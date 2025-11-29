
import 'package:ai_smart_fish_farming/src/global/constants/colors_resources.dart';
import 'package:flutter/material.dart';

// Temperature Graph Painter
class TemperatureGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.appColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorRes.appColor.withValues(alpha: 0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Temperature data points (normalized 0-1)
    final points = [
      Offset(0, 0.3),
      Offset(size.width * 0.14, 0.3),
      Offset(size.width * 0.28, 0.5),
      Offset(size.width * 0.42, 0.55),
      Offset(size.width * 0.56, 0.7),
      Offset(size.width * 0.70, 0.75),
      Offset(size.width * 0.84, 0.7),
      Offset(size.width, 0.3),
    ];

    // Create path for line
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy * size.height);

    for (int i = 1; i < points.length; i++) {
      final p0 = points[i - 1];
      final p1 = points[i];
      final controlX = (p0.dx + p1.dx) / 2;

      path.quadraticBezierTo(
        controlX,
        p0.dy * size.height,
        p1.dx,
        p1.dy * size.height,
      );
    }

    // Create fill path
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw temperature labels on graph
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final temps = ['27', '27', '26', '22', '21', '19', '18', '23'];
    for (int i = 0; i < points.length; i++) {
      textPainter.text = TextSpan(
        text: temps[i],
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          points[i].dx - textPainter.width / 2,
          points[i].dy * size.height - 20,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Weather Tab Widget
Widget buildWeatherTab(String label, bool isActive) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: isActive ? ColorRes.appColor.withValues(alpha: 0.2) : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isActive ? ColorRes.appColor.withValues(alpha: 0.5) : Colors.grey.withValues(alpha: 0.3),
        width: 1,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.black,
        fontSize: 11,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
      ),
    ),
  );
}

// Time Label Widget
Widget buildTimeLabel(String time) {
  return Text(
    time,
    style: TextStyle(
      color: Colors.black.withValues(alpha: 0.6),
      fontSize: 9,
      fontWeight: FontWeight.w400,
    ),
  );
}

// Day Card Widget
Widget buildDayCard(String day, IconData icon, String high, String low, bool isToday) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    decoration: BoxDecoration(
      color: isToday ? ColorRes.appColor.withValues(alpha: 0.15) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          day,
          style: TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Icon(
          icon,
          color: icon == Icons.wb_sunny ? Colors.orange : Colors.grey[600],
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          high,
          style: TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          low,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.6),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

// Main Weather Widget - Replace the commented container with this
Widget buildWeatherWidget() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: ColorRes.appBackColor,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.grey.withValues(alpha: 0.4),
        width: 1.5,
      ),
    ),
    child: Column(
      children: [
        // Top Section - Weather Icon & Temperature
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Weather Icon
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wb_sunny,
                color: Colors.white,
                size: 32,
              ),
            ),
            SizedBox(width: 16),

            // Temperature & Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "27",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "°C | °F",
                        style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "SQUIT  Precipitation: 0%",
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Humidity: 49%",
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Wind: 3 km/h",
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Right Side - Weather & Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Weather",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Saturday 12:00 PM",
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "Sunny",
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 20),

        // Tabs Section
        Row(
          children: [
            buildWeatherTab("Temperature", true),
            SizedBox(width: 8),
            buildWeatherTab("Precipitation", false),
            SizedBox(width: 8),
            buildWeatherTab("Wind", false),
          ],
        ),

        SizedBox(height: 16),

        // Temperature Graph
        SizedBox(
          height: 100,
          child: Stack(
            children: [
              // Graph Background
              CustomPaint(
                size: Size(double.infinity, 100),
                painter: TemperatureGraphPainter(),
              ),
              // Time Labels
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTimeLabel("1 PM"),
                    buildTimeLabel("4 PM"),
                    buildTimeLabel("7 PM"),
                    buildTimeLabel("10 PM"),
                    buildTimeLabel("1 AM"),
                    buildTimeLabel("4 AM"),
                    buildTimeLabel("7 AM"),
                    buildTimeLabel("10 AM"),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Weekly Forecast
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDayCard("Sat", Icons.wb_sunny, "28°", "16°", true),
            buildDayCard("Sun", Icons.cloud, "28°", "18°", false),
            buildDayCard("Mon", Icons.cloud, "27°", "19°", false),
            buildDayCard("Tue", Icons.cloud, "27°", "18°", false),
            buildDayCard("Wed", Icons.wb_sunny, "27°", "17°", false),
            buildDayCard("Thu", Icons.wb_sunny, "27°", "17°", false),
            buildDayCard("Fri", Icons.wb_sunny, "27°", "17°", false),
          ],
        ),
      ],
    ),
  );
}