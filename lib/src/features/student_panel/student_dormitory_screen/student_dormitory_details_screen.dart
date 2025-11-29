import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'widget/student_dormitory_details_widget.dart';

class StudentDormitoryDetailsScreen extends StatefulWidget {
  const StudentDormitoryDetailsScreen({super.key});

  @override
  State<StudentDormitoryDetailsScreen> createState() =>
      _StudentDormitoryDetailsScreenState();
}

class _StudentDormitoryDetailsScreenState
    extends State<StudentDormitoryDetailsScreen> with TickerProviderStateMixin {

  late PageController _pageController;
  late TabController _tabController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(
      builder: (homePageController) {
        return CustomScrollViewWidget(
          sliverAppBar: SliverAppBarWidget(
            titleText: "Abu Sayed Hall",
            expandedHeight: 60,
          ),
          slivers: [
            sliverSizedBoxH(20),
            StudentDormitoryDetailsWidget(
              houseName: 'Abu Sayed Hall',
              blockNumber: 'Block A',
              warden: 'Dr. Kamal Uddin',
              gender: 'boys',
              availableSpots: 5,
              totalCapacity: 40,
              rating: 4.8,
              galleryImages: const [
                'assets/dummy_img/01.jpg',
                'assets/dummy_img/02.jpg',
                'assets/dummy_img/03.jpg',
              ],
              amenities: const [
                {'name': 'Wi-Fi', 'icon': Icons.wifi, 'available': true},
                {
                  'name': 'Laundry',
                  'icon': Icons.local_laundry_service,
                  'available': true
                },
                {'name': 'Gym', 'icon': Icons.fitness_center, 'available': false},
                {'name': 'Library', 'icon': Icons.menu_book, 'available': true},
              ],
              rules: const [
                'Lights off by 11 PM.',
                'No loud music after 9 PM.',
                'Visitors must leave by 7 PM.',
              ],
              reviews: const [
                {
                  'name': 'Arman',
                  'date': '2025-07-01',
                  'rating': 4.5,
                  'comment': 'Very clean and well managed.'
                },
                {
                  'name': 'Samiha',
                  'date': '2025-07-15',
                  'rating': 5.0,
                  'comment': 'Loved the amenities and peaceful environment.'
                },
              ],
              pageController: _pageController,
              tabController: _tabController,
              currentImageIndex: _currentImageIndex,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              onContactTap: () {
                Get.snackbar('Contact', 'Calling warden...');
              },
              onApplyTap: () {
                Get.snackbar('Apply', 'Application submitted.');
              },
            ),
            sliverSizedBoxH(20),
          ],
        );
      },
    );
  }
}