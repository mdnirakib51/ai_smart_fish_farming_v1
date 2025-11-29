
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ai_smart_fish_farming/src/global/constants/images.dart';
import 'package:ai_smart_fish_farming/src/global/widget/global_image_loader.dart';
import 'package:ai_smart_fish_farming/src/global/widget/global_text.dart';
import 'package:ai_smart_fish_farming/src/service/auth/view/components/auth_background_com.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/constants/input_decoration.dart';
import '../../global/widget/global_bottom_widget.dart';
import '../../global/widget/global_sized_box.dart';
import '../../global/widget/global_textform_field.dart';
import 'container_space_back_widget.dart';

class OnBoardModel{
  String? img;
  String? text;
  String? subText;

  OnBoardModel({required this.img, required this.text, required this.subText});
}

class OnBoardingScreen extends StatefulWidget {
  final Function(String url) onUrlSubmitted;
  const OnBoardingScreen({
    super.key,
    required this.onUrlSubmitted,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with TickerProviderStateMixin {

  final TextEditingController _urlController = TextEditingController();
  // final TextEditingController _urlController = TextEditingController(text: "https://ems.stitbd.net");
  // final TextEditingController _urlController = TextEditingController(text: "https://lmphschool.stitbd.net");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentPageIndex = 0;

  late AnimationController _floatingController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _shimmerController;
  late AnimationController _particleController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _particleAnimation;

  List<OnBoardModel> images = [
    OnBoardModel(
      img: Images.onBoard1,
      text: "Smart Fish Farming",
      subText: "Monitor your ponds in real-time and manage everything from one smart dashboard.",
    ),
    OnBoardModel(
      img: Images.onBoard2,
      text: "Stay Notified",
      subText: "Receive instant alerts about water quality, feeding schedules, weather changes and more.",
    ),
    OnBoardModel(
      img: Images.onBoard3,
      text: "Track Farm Performance",
      subText: "Analyze daily reports, farm growth and performance insights to maximize productivity.",
    ),
  ];


  @override
  void initState() {
    super.initState();

    // Enhanced floating animation with different curves
    _floatingController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    _floatingAnimation = Tween<double>(
      begin: -15,
      end: 15,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOutSine,
    ));

    // Smoother rotation animation
    _rotationController = AnimationController(
      duration: Duration(seconds: 12),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    // Enhanced pulse animation
    _pulseController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.7,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOutCubic,
    ));

    // Smoother wave animation
    _waveController = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    );
    _waveAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.linear,
    ));

    // New shimmer effect
    _shimmerController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOutQuart,
    ));

    // Particle movement
    _particleController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    );
    _particleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.linear,
    ));

    // Start all animations
    _floatingController.repeat(reverse: true);
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _waveController.repeat();
    _shimmerController.repeat(reverse: true);
    _particleController.repeat();
  }

  @override
  void dispose() {
    _urlController.dispose();
    _floatingController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    _shimmerController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _submitUrl() {
    if (_formKey.currentState!.validate()) {
      final url = _urlController.text.trim();
      widget.onUrlSubmitted(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorRes.appBackColor,
      body: Stack(
        children: [
          _buildEnhancedAnimationEffects(context),

          Positioned(
            bottom: 0, left: 0, right: 0, top: 0,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.8),
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _floatingAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatingAnimation.value * 0.5),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Image Container with enhanced styling
                                    SizedBox(
                                      height: size(context).height * 0.35,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: GlobalImageLoader(
                                          imagePath: images[index].img ?? '',
                                          fit: BoxFit.fitWidth,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30),

                                    // Main Title Text
                                    GlobalText(
                                      str: images[index].text ?? '',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.center,
                                      color: ColorRes.appColor,
                                    ),

                                    // Subtitle Text
                                    GlobalText(
                                      str: images[index].subText ?? '',
                                      fontWeight: FontWeight.w400,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) => AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          bool isCurrentPage = index == currentPageIndex;
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: isCurrentPage
                                ? 14 + (_pulseAnimation.value * 3)
                                : 6,
                            height: isCurrentPage
                                ? 4 + (_pulseAnimation.value * 3)
                                : 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: isCurrentPage
                                  ? ColorRes.appColor
                                  : Colors.grey.withValues(alpha: 0.5),
                              boxShadow: isCurrentPage ? [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ] : null,  // Shadow only for current page
                            ),
                          );
                        },
                      ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: ContainerSpaceBackWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          sizedBoxH(20),
                          GlobalButtonWidget(
                            str: "Get Started",
                            radius: 8,
                            height: 42,
                            textSize: 14,
                            buttomColor: ColorRes.orange,
                            onTap: _submitUrl,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.code,
                                color: ColorRes.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              AnimatedBuilder(
                                animation: _shimmerAnimation,
                                builder: (context, child) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: ShaderMask(
                                      shaderCallback: (bounds) => LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          ColorRes.white.withValues(alpha: 0.5),
                                          ColorRes.white,
                                          ColorRes.white.withValues(alpha: 0.5),
                                        ],
                                        stops: [
                                          0.0,
                                          _shimmerAnimation.value,
                                          1.0,
                                        ],
                                      ).createShader(bounds),
                                      child: GlobalText(
                                        str: "Developed By AI smart fish farm",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
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
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedAnimationEffects(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _floatingAnimation,
        _rotationAnimation,
        _pulseAnimation,
        _waveAnimation,
        _shimmerAnimation,
        _particleAnimation,
      ]),
      builder: (context, child) => Stack(
        children: [
          // Background shimmer effect
          _buildShimmerEffect(context),
          // Floating particles
          _buildFloatingParticles(context),
          // Top purple area animations
          ..._buildEnhancedTopAreaAnimations(context),
          // Bottom purple area animations
          ..._buildEnhancedBottomAreaAnimations(context),
          // Connecting light rays
          _buildLightRays(context),
        ],
      ),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: CustomPaint(
        painter: ShimmerEffectPainter(_shimmerAnimation.value),
      ),
    );
  }

  Widget _buildFloatingParticles(BuildContext context) {
    return Stack(
      children: List.generate(15, (index) {
        double animationOffset = (index * 0.3) % 1.0;
        double adjustedAnimation = (_particleAnimation.value + animationOffset) % 1.0;

        return Positioned(
          left: (size(context).width * 0.1) + (index * size(context).width * 0.05),
          top: size(context).height * 0.2 + (adjustedAnimation * size(context).height * 0.6),
          child: Transform.scale(
            scale: 0.5 + (adjustedAnimation * 0.5),
            child: Container(
              width: 4 + (index % 3) * 2,
              height: 4 + (index % 3) * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.15 - (adjustedAnimation * 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLightRays(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: CustomPaint(
        painter: LightRaysPainter(_shimmerAnimation.value),
      ),
    );
  }

  List<Widget> _buildEnhancedTopAreaAnimations(BuildContext context) {
    return [
      // Large glowing bubble with enhanced effects
      Positioned(
        top: 40 + _floatingAnimation.value,
        right: 50,
        child: Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.3),
                  Colors.white.withValues(alpha: 0.15),
                  Colors.white.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: [0.0, 0.4, 0.8, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
        ),
      ),

      // Medium floating bubbles with glow
      ...List.generate(2, (index) => Positioned(
        top: 70 + (index * 40) + (_floatingAnimation.value * (index % 2 == 0 ? 0.8 : -0.8)),
        left: 40 + (index * 60),
        child: Transform.scale(
          scale: _pulseAnimation.value * (0.7 + index * 0.1),
          child: Container(
            width: 70 - (index * 10),
            height: 70 - (index * 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.25 - (index * 0.05)),
                  Colors.white.withValues(alpha: 0.12 - (index * 0.02)),
                  Colors.white.withValues(alpha: 0.04),
                  Colors.transparent,
                ],
                stops: [0.0, 0.5, 0.8, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.15),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
          ),
        ),
      )),

      // Enhanced rotating geometric shapes
      ...List.generate(4, (index) => Positioned(
        top: 50 + (index * 25),
        right: 100 + (index * 45),
        child: Transform.rotate(
          angle: _rotationAnimation.value * 3.14159 * (index % 2 == 0 ? 1 : -1) + (index * 0.785),
          child: Container(
            width: 25 + (index * 3),
            height: 25 + (index * 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2 - (index * 0.03)),
                  Colors.white.withValues(alpha: 0.08 - (index * 0.01)),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.1),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      )),

      // Enhanced wave patterns
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          height: size(context).height * 0.35,
          child: CustomPaint(
            painter: EnhancedWavePatternPainter(
              _waveAnimation.value,
              _shimmerAnimation.value,
              isTopArea: true,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildEnhancedBottomAreaAnimations(BuildContext context) {
    return [
      // Large glowing bubble in bottom area
      Positioned(
        bottom: 50 + (_floatingAnimation.value * -1),
        left: 60,
        child: Transform.scale(
          scale: _pulseAnimation.value * 0.9,
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.28),
                  Colors.white.withValues(alpha: 0.14),
                  Colors.white.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
                stops: [0.0, 0.4, 0.8, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.18),
                  blurRadius: 18,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),

      // Medium floating bubbles in bottom area
      ...List.generate(3, (index) => Positioned(
        bottom: 60 + (index * 30) + (_floatingAnimation.value * (index % 2 == 0 ? 0.6 : -0.6)),
        right: 50 + (index * 55),
        child: Transform.scale(
          scale: _pulseAnimation.value * (0.6 + index * 0.08),
          child: Container(
            width: 65 - (index * 8),
            height: 65 - (index * 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.22 - (index * 0.04)),
                  Colors.white.withValues(alpha: 0.11 - (index * 0.02)),
                  Colors.white.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: [0.0, 0.5, 0.8, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.12),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      )),

      // Enhanced rotating shapes in bottom area
      ...List.generate(4, (index) => Positioned(
        bottom: 70 + (index * 20),
        left: 90 + (index * 50),
        child: Transform.rotate(
          angle: _rotationAnimation.value * -3.14159 * (index % 2 == 0 ? 1 : -1) + (index * 0.785),
          child: Container(
            width: 22 + (index * 2),
            height: 22 + (index * 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.18 - (index * 0.025)),
                  Colors.white.withValues(alpha: 0.07 - (index * 0.01)),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.08),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      )),

      // Enhanced wave patterns in bottom area
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          height: size(context).height * 0.3,
          child: CustomPaint(
            painter: EnhancedWavePatternPainter(
              _waveAnimation.value,
              _shimmerAnimation.value,
              isTopArea: false,
            ),
          ),
        ),
      ),
    ];
  }
}
