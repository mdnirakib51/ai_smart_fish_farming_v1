
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_text.dart';
import '../../student_home_screen/controller/student_home_controller.dart';
import '../../../widget/student_flexible_space_back_widget.dart';
import '../../../widget/student_menu_background_container.dart';

class StudentPaymentReviewScreen extends StatefulWidget {
  const StudentPaymentReviewScreen({super.key});

  @override
  State<StudentPaymentReviewScreen> createState() => _StudentPaymentReviewScreenState();
}

class _StudentPaymentReviewScreenState extends State<StudentPaymentReviewScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Sample fee data - replace with your actual data source
  final List<Map<String, dynamic>> feeDetails = [
    {
      'title': 'Course Fees',
      'amount': 15000,
      'icon': Icons.school,
      'color': Colors.blue
    },
    {
      'title': 'School Bus',
      'amount': 2000,
      'icon': Icons.directions_bus,
      'color': Colors.orange
    },
    {
      'title': 'Sport Fees',
      'amount': 1000,
      'icon': Icons.sports_soccer,
      'color': Colors.green
    },
    {
      'title': 'ID Card Amount',
      'amount': 300,
      'icon': Icons.badge,
      'color': Colors.purple
    },
    {
      'title': 'Computer Lab Fees',
      'amount': 500,
      'icon': Icons.computer,
      'color': Colors.red
    },
  ];

  int get totalAmount => feeDetails.fold(0, (sum, item) => sum + (item['amount'] as int));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},'
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Payment Review",
          expandedHeight: 180,
          flexibleSpace: StudentFlexibleSpaceBackWidget(
              child: StudentMenuBackgroundContainer(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SizedBox(
                      width: size(context).width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Icon(
                          //   Icons.account_balance_wallet,
                          //   color: ColorRes.appColor,
                          //   size: 40,
                          // ),
                          sizedBoxH(8),
                          GlobalText(
                            str: 'Total Pending Payment',
                            fontSize: 14,
                            color: ColorRes.appColor.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                          sizedBoxH(8),
                          TweenAnimationBuilder<int>(
                            tween: IntTween(begin: 0, end: totalAmount),
                            duration: const Duration(milliseconds: 1500),
                            builder: (context, value, child) {
                              return GlobalText(
                                str: '৳ ${formatCurrency(value)}',
                                fontSize: 30,
                                color: ColorRes.appColor,
                                fontWeight: FontWeight.bold,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ),
        slivers: [
          sliverSizedBoxH(20),

          // Fees Details Header
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.receipt_long,
                    color: ColorRes.appColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  GlobalText(
                    str: 'Fee Breakdown',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorRes.black,
                  ),
                ],
              ),
            ),
          ),

          sliverSizedBoxH(16),

          // Fee Details List with Animation
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Individual fee items with staggered animation
                  ...feeDetails.asMap().entries.map((entry) {
                    final index = entry.key;
                    final fee = entry.value;
                    final isLast = index == feeDetails.length - 1;

                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: isLast ? null : Border(
                          bottom: BorderSide(
                            color: Colors.grey.shade100,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: fee['color'].withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              fee['icon'],
                              color: fee['color'],
                              size: 16,
                            ),
                          ),
                          sizedBoxW(10),
                          Expanded(
                            child: GlobalText(
                              str: fee['title'],
                              color: ColorRes.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GlobalText(
                            str: '৳ ${formatCurrency(fee['amount'])}',
                            fontSize: 15,
                            color: ColorRes.deep400,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    );
                  }),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),

                  // Total Fees
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorRes.appColor.withValues(alpha: 0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calculate,
                              color: ColorRes.appColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            GlobalText(
                              str: 'Total Fees',
                              fontSize: 15,
                              color: ColorRes.appColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        GlobalText(
                          str: '৳ ${formatCurrency(totalAmount)}',
                          fontSize: 15,
                          color: ColorRes.appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),

                  // Total Due
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorRes.appRedColor.withValues(alpha: 0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.remove_circle_outline,
                              color: ColorRes.appRedColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            GlobalText(
                              str: 'Total Due',
                              fontSize: 15,
                              color: ColorRes.appRedColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        GlobalText(
                          str: '৳ 3,800',
                          fontSize: 15,
                          color: ColorRes.appRedColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),

                  // Final Amount
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorRes.green.withValues(alpha: 0.08),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: ColorRes.green,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            GlobalText(
                              str: 'Final Amount',
                              fontSize: 16,
                              color: ColorRes.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        GlobalText(
                          str: '৳ 15,000',
                          fontSize: 16,
                          color: ColorRes.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          sliverSizedBoxH(24),
          // Pay Now Button with Animation
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GlobalButtonWidget(
                str: 'Pay Now',
                height: 45,
                radius: 8,
                onTap: (){
                  Get.to(()=> StudentPaymentReviewScreen());
                },
              ),
            ),
          ),

          sliverSizedBoxH(20),
          // Security Note
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.shield, color: Colors.blue.shade600, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GlobalText(
                      str: 'Your payment is secured with 256-bit SSL encryption',
                      fontSize: 12,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          sliverSizedBoxH(30),
        ],
      );
    });
  }
}
