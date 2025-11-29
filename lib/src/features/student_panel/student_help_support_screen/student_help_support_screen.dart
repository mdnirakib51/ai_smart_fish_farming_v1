import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../global/custom_scroll_view/custom_scroll_view_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../student_home_screen/controller/student_home_controller.dart';
import 'widget/student_help_support_widget.dart';

class StudentHelpSupportScreen extends StatefulWidget {
  const StudentHelpSupportScreen({super.key});

  @override
  State<StudentHelpSupportScreen> createState() => _StudentHelpSupportScreenState();
}

class _StudentHelpSupportScreenState extends State<StudentHelpSupportScreen> {
  String _appName = "ST Edu";
  String _version = "Unknown";
  String _buildNumber = "Unknown";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homePageController = StudentHomePageController.current;
      homePageController.getStudentsProfileView();
      _fetchAppInfo();
    });
  }

  Future<void> _fetchAppInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appName = packageInfo.appName;
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
      });
    } catch (e) {
      debugPrint("Failed to fetch app info: $e");
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        Get.snackbar('Error', 'Could not launch $url');
      }
    } catch (e, s) {
      log("Could not launch: $url", error: e, stackTrace: s);
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        Get.snackbar('Error', 'Could not launch $launchUri');
      }
    } catch (e, s) {
      log("Could not launch phone: ", error: e, stackTrace: s);
    }
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: const Color(0xFF00C9A7).withValues(alpha: 0.9),
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
      snackPosition: SnackPosition.TOP,
    );
  }

  Widget _buildQuickSupportCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String phoneNumber,
    required VoidCallback onTap,
    required List<Color> gradientColors,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                        ),
                      ),
                      if (phoneNumber.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            phoneNumber,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentHomePageController>(builder: (homePageController) {
      final organization = homePageController.studentProfileModel?.organization;
      final phoneNumber = organization?.phone ?? "";
      final email = organization?.email ?? "";
      final address = organization?.address ?? "";

      return CustomScrollViewWidget(
        sliverAppBar: SliverAppBarWidget(
          titleText: "Help & Support",
          expandedHeight: 60,
        ),
        bottomSheet: StudentAppInfoWidget(
          appName: "Developed By STIT BD",
          version: _version,
          buildNumber: _buildNumber,
          imagePath: 'assets/app_images/stedu.png',
        ),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              // Quick Support Section
              _buildInfoSection(
                title: '⚡ Quick Support',
                child: Column(
                  children: [
                    // Phone Support Card
                    _buildQuickSupportCard(
                      icon: Icons.phone_rounded,
                      title: '📞 Call Support',
                      subtitle: 'Call us for immediate assistance',
                      phoneNumber: phoneNumber.isNotEmpty ? phoneNumber : 'Phone number not available',
                      onTap: () async {
                        if (phoneNumber.isNotEmpty) {
                          await _launchPhone(phoneNumber);
                        } else {
                          Get.snackbar('Error', 'Phone number is not available');
                        }
                      },
                      gradientColors: [const Color(0xFF00C9A7), const Color(0xFF00B4D8)],
                    ),

                    // Email Support Card
                    if (email.isNotEmpty)
                      _buildQuickSupportCard(
                        icon: Icons.email_rounded,
                        title: '📧 Email Support',
                        subtitle: 'Contact us via email',
                        phoneNumber: email,
                        onTap: () async {
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: email,
                            query: 'subject=Support Request&body=Hello, I need help with...',
                          );
                          await _launchURL(emailUri.toString());
                        },
                        gradientColors: [const Color(0xFFFF6B35), const Color(0xFFFF8E53)],
                      ),
                  ],
                ),
              ),

              // Contact Information Section
              if (address.isNotEmpty)
                _buildInfoSection(
                  title: '📍 Contact Information',
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: const Color(0xFF00C9A7),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Address',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          address,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Social Media Section
              _buildInfoSection(
                title: '✨ Follow Us',
                child: Row(
                  children: [
                    _buildSocialMediaCard(
                      icon: Icons.facebook_rounded,
                      label: "Facebook",
                      color: const Color(0xFF1877F2),
                      onTap: () async {
                        final url = organization?.fbPageLink ?? "";
                        if (url.isNotEmpty) {
                          await _launchURL(url);
                        } else {
                          Get.snackbar('Error', 'Facebook URL is empty');
                        }
                      },
                    ),
                    const SizedBox(width: 12),
                    _buildSocialMediaCard(
                      icon: Icons.language_rounded,
                      label: "Website",
                      color: const Color(0xFF00C9A7),
                      onTap: () async {
                        final url = organization?.website ?? "";
                        if (url.isNotEmpty) {
                          await _launchURL(url);
                        } else {
                          Get.snackbar('Error', 'Website URL is empty');
                        }
                      },
                    ),
                    // const SizedBox(width: 12),
                    // _buildSocialMediaCard(
                    //   icon: Icons.map_rounded,
                    //   label: "Map",
                    //   color: const Color(0xFFFF6B35),
                    //   onTap: () async {
                    //     final url = organization?.mapLink ?? "";
                    //     if (url.isNotEmpty) {
                    //       await _launchURL(url);
                    //     } else {
                    //       Get.snackbar('Error', 'Map URL is empty');
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),

              sizedBoxH(100), // Bottom spacing for bottomSheet
            ]),
          ),
        ],
      );
    });
  }

  Widget _buildHelpTopicItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C9A7).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF00C9A7),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}