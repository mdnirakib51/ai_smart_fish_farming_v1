import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../student_drawer/view/student_drawer_screen.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import '../../widget/student_flexible_space_back_widget.dart';
import 'student_driver_screen.dart';
import 'widget/student_driver_profile_detail_widget.dart';

class StudentTransportScreen extends StatefulWidget {
  const StudentTransportScreen({super.key});

  @override
  State<StudentTransportScreen> createState() => _StudentTransportScreenState();
}

class _StudentTransportScreenState extends State<StudentTransportScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        scaffoldKey: drawerKey,
        drawer: StudentCustomDrawer(),
        sliverAppBar: SliverAppBarWidget(
          titleText: "Transport",
          flexibleSpace: StudentFlexibleSpaceBackWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      GlobalText(
                        str: 'Select Route',
                        fontSize: 16,
                        color: ColorRes.white,
                      ),
                      sizedBoxH(5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Added const
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row( // Added const
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GlobalText(
                              str: "Panthpoth Road",
                              color: ColorRes.white,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorRes.white,
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
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 530,
              child: Stack(
                children: [
                  const MapWidget(),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: DriverInfoWidget(
                      name: "Mohammad Ali",
                      designation: 'Driver',
                      busNumber: '134 - Line 3',
                      startingTime: '8.00 am',
                      arrivingTime: '8.45 am',
                      onTap: () {
                        Get.to(() => const StudentDriverProfileScreen());                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          sliverSizedBoxH(20),
        ],
      );
    });
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: MapPainter(),
        child: const Stack( // Added const
          children: [
            // Map markers
            Positioned(
              top: 200,
              left: 100,
              child: MapMarker(
                icon: Icons.location_on,
                color: Colors.orange,
                label: 'Shyamoli',
              ),
            ),
            Positioned(
              top: 250,
              left: 200,
              child: MapMarker(
                icon: Icons.location_city_outlined,
                color: Colors.blue,
                label: 'Rawa Plaza',
              ),
            ),
            Positioned(
              top: 300,
              left: 150,
              child: MapMarker(
                icon: Icons.restaurant,
                color: Colors.orange,
                label: 'KFC',
              ),
            ),
            Positioned(
              top: 350,
              left: 120,
              child: MapMarker(
                icon: Icons.store,
                color: Colors.orange,
                label: 'Bosundhara City',
              ),
            ),
            Positioned(
              top: 400,
              left: 180,
              child: MapMarker(
                icon: Icons.local_hospital,
                color: Colors.blue,
                label: 'BRB Hospital',
              ),
            ),
            // Route line
            Positioned(
              top: 180,
              left: 80,
              child: RouteLineWidget(),
            ),
            // Driver location
            Positioned(
              top: 320,
              left: 250,
              child: DriverLocationMarker(),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF0F0F0) // Added const
      ..style = PaintingStyle.fill;

    // Draw simple map background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw streets
    final streetPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Horizontal streets
    for (int i = 0; i < 10; i++) {
      canvas.drawLine(
        Offset(0, i * 60.0),
        Offset(size.width, i * 60.0),
        streetPaint,
      );
    }

    // Vertical streets
    for (int i = 0; i < 8; i++) {
      canvas.drawLine(
        Offset(i * 50.0, 0),
        Offset(i * 50.0, size.height),
        streetPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MapMarker extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const MapMarker({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4), // Added const
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(height: 2), // Added const
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // Added const
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [ // Added const
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
              ),
            ],
          ),
          child: Text(
            label,
            style: const TextStyle( // Added const
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class RouteLineWidget extends StatelessWidget {
  const RouteLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200), // Added const
      painter: RouteLinePainter(),
    );
  }
}

class RouteLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Draw dashed route line
    Path path = Path();
    path.moveTo(20, 20);
    path.lineTo(80, 60);
    path.lineTo(120, 120);
    path.lineTo(160, 140);

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + 10);
        canvas.drawPath(segment, paint);
        distance += 20;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DriverLocationMarker extends StatelessWidget {
  const DriverLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon( // Added const
        Icons.directions_car,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
