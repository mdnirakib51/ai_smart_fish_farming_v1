import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../../widget/student_menu_tile_container.dart';

class StudentDormitoryDetailsWidget extends StatelessWidget {
  const StudentDormitoryDetailsWidget({
    super.key,
    required this.houseName,
    required this.blockNumber,
    required this.warden,
    required this.gender,
    required this.availableSpots,
    required this.totalCapacity,
    required this.rating,
    required this.galleryImages,
    required this.amenities,
    required this.rules,
    required this.reviews,
    required this.pageController,
    required this.tabController,
    required this.currentImageIndex,
    required this.onPageChanged,
    required this.onContactTap,
    required this.onApplyTap,
    this.color,
    this.itemCount,
  });

  final String houseName;
  final String blockNumber;
  final String warden;
  final String gender;
  final int availableSpots;
  final int totalCapacity;
  final double rating;
  final List<String> galleryImages;
  final List<Map<String, dynamic>> amenities;
  final List<String> rules;
  final List<Map<String, dynamic>> reviews;
  final PageController pageController;
  final TabController tabController;
  final int currentImageIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onContactTap;
  final VoidCallback onApplyTap;
  final Color? color;
  final int? itemCount;

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

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? (itemCount != null ? colorList[(itemCount! - 1) % colorList.length] : ColorRes.appColor);
    double occupancyRate = (totalCapacity - availableSpots) / totalCapacity;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      itemCount: galleryImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 200,
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: GlobalImageLoader(
                              imagePath: galleryImages[index],
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    // Dot Indicator
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: galleryImages.asMap().entries.map((entry) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentImageIndex == entry.key
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // Image Count
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: GlobalText(
                          str:
                              '${currentImageIndex + 1}/${galleryImages.length}',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            sizedBoxH(20),
            StudentMenuTileContainer(
              color: color,
              child: Container(
                width: size(context).width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: houseName,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E293B),
                              ),
                              sizedBoxH(4),
                              GlobalText(
                                str: blockNumber,
                                fontSize: 16,
                                color: const Color(0xFF64748B),
                              ),
                            ],
                          ),
                        ),
                        // Rating
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: color.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star,
                                  color: Color(0xFFFBBF24), size: 16),
                              sizedBoxW(4),
                              GlobalText(
                                str: rating.toStringAsFixed(1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: color,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBoxH(20),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: color.withValues(alpha: 0.1)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.bed_outlined, color: color, size: 24),
                              sizedBoxH(8),
                              GlobalText(
                                str: availableSpots.toString(),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: availableSpots > 10
                                    ? const Color(0xFF059669)
                                    : availableSpots > 5
                                        ? const Color(0xFFD97706)
                                        : const Color(0xFFDC2626),
                              ),
                              sizedBoxH(4),
                              GlobalText(
                                str: "Available",
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        sizedBoxW(12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: color.withValues(alpha: 0.1)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.people_outline,
                                  color: color, size: 24),
                              sizedBoxH(8),
                              GlobalText(
                                str: totalCapacity.toString(),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                              sizedBoxH(4),
                              GlobalText(
                                str: 'Total Set',
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        sizedBoxW(12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: color.withValues(alpha: 0.1)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.pie_chart_outline,
                                  color: color, size: 24),
                              sizedBoxH(8),
                              GlobalText(
                                str: '${(occupancyRate * 100).toInt()}%',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                              sizedBoxH(4),
                              GlobalText(
                                str: 'Occupied',
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBoxH(20),
                    /// Warden
                    Row(
                      children: [
                        Icon(Icons.person_outline,
                            color: const Color(0xFF64748B), size: 16),
                        sizedBoxW(8),
                        GlobalText(
                          str: "Hall Provost:",
                          fontSize: 14,
                          color: const Color(0xFF64748B),
                        ),
                        GlobalText(
                          str: "warden",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ],
                    ),
                    sizedBoxH(12),
                    /// Gender
                    Row(
                      children: [
                        Icon(gender == 'boys' ? Icons.male : Icons.female,
                            color: const Color(0xFF64748B), size: 16),
                        sizedBoxW(8),
                        GlobalText(
                          str: "Gender: ",
                          fontSize: 14,
                          color: const Color(0xFF64748B),
                        ),
                        GlobalText(
                          str: gender == 'boys'
                              ? 'Only for Boys'
                              : 'Only for Girls',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            StudentMenuTileContainer(
              color: color,
              child: Container(
                width: size(context).width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TabBar(
                      controller: tabController,
                      indicatorColor: color,
                      labelColor: color,
                      unselectedLabelColor: const Color(0xFF64748B),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(text: 'Amenities'),
                        Tab(text: 'Rules'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          // Amenities
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 2.5,
                              ),
                              itemCount: amenities.length,
                              itemBuilder: (context, index) {
                                final amenity = amenities[index];
                                final isAvailable =
                                    (amenity['available'] as bool?) ?? false;
                                final iconData = amenity['icon'] as IconData?;
                                final name = amenity['name'] as String? ?? '';

                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isAvailable
                                        ? color.withValues(alpha: 0.08)
                                        : const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isAvailable
                                          ? color.withValues(alpha: 0.2)
                                          : const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: isAvailable
                                              ? color.withValues(alpha: 0.1)
                                              : const Color(0xFFE2E8F0),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          iconData ?? Icons.help_outline,
                                          size: 16,
                                          color: isAvailable
                                              ? color
                                              : const Color(0xFF94A3B8),
                                        ),
                                      ),
                                      sizedBoxW(12),
                                      Expanded(
                                        child: GlobalText(
                                          str: name,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: isAvailable
                                              ? color
                                              : const Color(0xFF94A3B8),
                                        ),
                                      ),
                                      if (!isAvailable)
                                        Icon(Icons.close_rounded,
                                            size: 16,
                                            color: const Color(0xFF94A3B8)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          // Rules
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: rules.length,
                              itemBuilder: (context, index) {
                                final rule =
                                    rules.length > index ? rules[index] : '';
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: color.withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Center(
                                          child: GlobalText(
                                            str: '${index + 1}',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: color,
                                          ),
                                        ),
                                      ),
                                      sizedBoxW(16),
                                      Expanded(
                                        child: GlobalText(
                                          str: rule,
                                          fontSize: 14,
                                          color: const Color(0xFF475569),
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          // Reviews
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                final review = reviews[index];
                                final reviewName =
                                    review['name'] as String? ?? 'Anonymous';
                                final reviewDate =
                                    review['date'] as String? ?? '';
                                final reviewRating =
                                    (review['rating'] as num?)?.toDouble() ??
                                        0.0;
                                final reviewComment =
                                    review['comment'] as String? ?? '';

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: const Color(0xFFE2E8F0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.04),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  color.withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: GlobalText(
                                                str:
                                                    reviewName[0].toUpperCase(),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: color,
                                              ),
                                            ),
                                          ),
                                          sizedBoxW(12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GlobalText(
                                                  str: reviewName,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF1A1D29),
                                                ),
                                                GlobalText(
                                                  str: reviewDate,
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xFF64748B),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFBBF24)
                                                  .withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.star_rounded,
                                                    size: 14,
                                                    color: Color(0xFFFBBF24)),
                                                sizedBoxW(4),
                                                GlobalText(
                                                  str: reviewRating
                                                      .toStringAsFixed(1),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFFFBBF24),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      sizedBoxH(12),
                                      GlobalText(
                                        str: reviewComment,
                                        fontSize: 14,
                                        color: const Color(0xFF475569),
                                        height: 1.4,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            StudentMenuTileContainer(
              color: color,
              child: Container(
                width: size(context).width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GlobalText(
                      str: 'Booking info',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                    sizedBoxH(16),
                    Row(
                      children: const [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: 'Monthly Fee',
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                              GlobalText(
                                str: '৳5,500',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GlobalText(
                                str: 'Security Deposit',
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                              GlobalText(
                                str: '৳25,000',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sizedBoxH(20),
                    Row(
                      children: [
                        Expanded(
                          child: GlobalButtonWidget(
                            str: 'Contact Provost',
                            textColor: ColorRes.appColor,
                            borderColor: ColorRes.appColor,
                            buttomColor: ColorRes.white,
                            height: 45,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        sizedBoxW(12),
                        Expanded(
                          child: GlobalButtonWidget(
                            str: availableSpots > 0 ? 'Apply Now' : 'Full',
                            height: 45,
                            onTap: () {
                              availableSpots > 0 ? onApplyTap : null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
