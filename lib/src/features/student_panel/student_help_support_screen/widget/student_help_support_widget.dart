import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_text.dart';

class GlowingActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;
  final VoidCallback onTap;

  const GlowingActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black.withValues(alpha:0.1),
              width: .5,
            ),
            boxShadow: [
              BoxShadow(
                color: gradient[0].withValues(alpha:0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: gradient[0].withValues(alpha:0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      str: title,
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 6),
                    GlobalText(
                      str: subtitle,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MagicalSocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const MagicalSocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [color, color.withValues(alpha:0.7)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(height: 5),
            GlobalText(
              str: label,
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: color.withValues(alpha:0.3),
              width: .5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha:0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: color.withValues(alpha:0.3),
                  ),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      str: title,
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 6),
                    GlobalText(
                      str: subtitle,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradient;

  const HeroCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha:0.4),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha:0.4),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha:0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 36),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(
                  str: title,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 5),
                GlobalText(
                  str: subtitle,
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class StudentAppInfoWidget extends StatelessWidget {
  final String appName;
  final String version;
  final String buildNumber;
  final String imagePath;

  const StudentAppInfoWidget({
    super.key,
    required this.appName,
    required this.version,
    required this.buildNumber,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        border: Border.all(
          color: ColorRes.appColor.withValues(alpha: 0.3),
          width: .5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   //padding: const EdgeInsets.all(5),
              //   // decoration: BoxDecoration(
              //   //   borderRadius: BorderRadius.circular(5),
              //   //   border: Border.all(
              //   //     color: ColorRes.appColor.withValues(alpha: 0.1),
              //   //     width: .5,
              //   //   ),
              //   // ),
              //   child: GlobalImageLoader(
              //     imagePath: imagePath,
              //     height: 28,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              // sizedBoxW(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GlobalText(
                    str: appName,
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  GlobalText(
                    str: 'Version: v$version ($buildNumber)',
                    color: Colors.black87,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
          // sizedBoxH(5),
          // GlobalText(
          //   str: '💖 ধন্যবাদ আমাদের সাথে থাকার জন্য',
          //   color: Colors.grey.shade600,
          //   fontSize: 12,
          //   fontWeight: FontWeight.w500,
          //   fontStyle: FontStyle.italic,
          // ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../../../../global/constants/colors_resources.dart';
// import '../../../../global/widget/global_sized_box.dart';
// import '../../../../global/widget/global_text.dart';
//
// class StudentNotificationItemWidget extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String? details;
//   final String time;
//   final Color color;
//   final bool isRead;
//   final VoidCallback? onTap;
//
//   const StudentNotificationItemWidget({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     this.details,
//     required this.time,
//     required this.color,
//     this.isRead = false,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(16),
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: color.withValues(alpha:0.05),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: color.withValues(alpha:0.1),
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.notification_important_outlined,
//                                   color: color,
//                                   size: 16,
//                                 ),
//                                 sizedBoxW(5),
//                                 Expanded(
//                                   child: GlobalText(
//                                     str: title,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: ColorRes.deep400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       sizedBoxH(4),
//                       GlobalText(
//                         str: subtitle,
//                         color: ColorRes.deep100,
//                       ),
//                       sizedBoxH(4),
//                       GlobalText(
//                         str: time,
//                         fontSize: 12,
//                         color: ColorRes.grey,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }