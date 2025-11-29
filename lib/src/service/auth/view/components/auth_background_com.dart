import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_container.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../controller/auth_controller.dart';

class AuthBackGroundCom extends StatefulWidget {
  final List<Widget> children;
  const AuthBackGroundCom({
    super.key,
    this.children = const <Widget>[]
  });

  @override
  State<AuthBackGroundCom> createState() => _AuthBackGroundComState();
}

class _AuthBackGroundComState extends State<AuthBackGroundCom> with TickerProviderStateMixin {

  late AnimationController _fishController;
  late AnimationController _bubbleController;
  late AnimationController _waveController;
  late AnimationController _rippleController;

  late Animation<double> _fishAnimation;
  late Animation<double> _bubbleAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();

    // Fish swimming animation
    _fishController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    );
    _fishAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _fishController, curve: Curves.easeInOutSine)
    );

    // Bubble floating animation
    _bubbleController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );
    _bubbleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _bubbleController, curve: Curves.linear)
    );

    // Water wave animation
    _waveController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    );
    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _waveController, curve: Curves.linear)
    );

    // Ripple animation
    _rippleController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _rippleAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _rippleController, curve: Curves.easeOut)
    );

    _fishController.repeat();
    _bubbleController.repeat();
    _waveController.repeat();
    _rippleController.repeat();
  }

  @override
  void dispose() {
    _fishController.dispose();
    _bubbleController.dispose();
    _waveController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GlobalContainer(
        height: size(context).height,
        width: size(context).width,
        color: Colors.white,
        child: Stack(
          children: [
            // Ocean gradient background
            Container(
              height: size(context).height,
              width: size(context).width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1e3c72), // Deep ocean blue
                    Color(0xFF2a5298), // Medium blue
                    Color(0xFF3d7ea6), // Light blue
                    Color(0xFF5fa0b8), // Cyan blue
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                ),
              ),
            ),

            // Animated water effects
            AnimatedBuilder(
              animation: Listenable.merge([
                _fishAnimation,
                _bubbleAnimation,
                _waveAnimation,
                _rippleAnimation,
              ]),
              builder: (context, child) => Stack(
                children: [
                  // Underwater plants at bottom
                  _buildUnderwaterPlants(context),

                  // Water ripples
                  _buildWaterRipples(context),

                  // Floating bubbles
                  ..._buildBubbles(context),

                  // Swimming fish
                  ..._buildFish(context),

                  // Wave patterns
                  _buildWavePattern(context),

                  // Surface shimmer effect
                  _buildSurfaceShimmer(context),
                ],
              ),
            ),

            // Content overlay with frosted glass effect
            Positioned(
              left: 10,
              right: 10,
              bottom: 0,
              top: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.children,
              ),
            ),
          ],
        ),
      );
    });
  }

  // Build underwater plants at the bottom
  Widget _buildUnderwaterPlants(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        size: Size(size(context).width, 150),
        painter: UnderwaterPlantsPainter(_waveAnimation.value),
      ),
    );
  }

  // Build water ripples
  Widget _buildWaterRipples(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        size: Size(size(context).width, size(context).height * 0.3),
        painter: WaterRipplePainter(_rippleAnimation.value),
      ),
    );
  }

  // Build floating bubbles
  List<Widget> _buildBubbles(BuildContext context) {
    return List.generate(15, (index) {
      double animOffset = (index * 0.2) % 1.0;
      double progress = (_bubbleAnimation.value + animOffset) % 1.0;

      return Positioned(
        left: (index * size(context).width * 0.07) % size(context).width,
        bottom: -50 + (progress * (size(context).height + 100)),
        child: Opacity(
          opacity: (1 - progress) * 0.6,
          child: Container(
            width: 8 + (index % 4) * 4,
            height: 8 + (index % 4) * 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.3),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
        ),
      );
    });
  }

  // Build swimming fish
  List<Widget> _buildFish(BuildContext context) {
    return List.generate(5, (index) {
      double animOffset = (index * 0.25) % 1.0;
      double progress = (_fishAnimation.value + animOffset) % 1.0;

      double startX = index % 2 == 0 ? -100 : size(context).width + 100;
      double endX = index % 2 == 0 ? size(context).width + 100 : -100;
      double xPos = startX + (endX - startX) * progress;

      double yBase = 100 + (index * 100);
      double yOffset = sin(progress * pi * 4) * 30;

      bool flipHorizontal = index % 2 != 0;

      return Positioned(
        left: xPos,
        top: yBase + yOffset,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(flipHorizontal ? -1.0 : 1.0, 1.0),
          child: Opacity(
            opacity: 0.4 + (sin(progress * pi) * 0.3),
            child: CustomPaint(
              size: Size(60 + (index * 10), 30 + (index * 5)),
              painter: FishPainter(
                color: index % 3 == 0
                    ? Color(0xFFFF6B6B)
                    : index % 3 == 1
                    ? Color(0xFFFFD93D)
                    : Color(0xFF6BCB77),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Build wave pattern
  Widget _buildWavePattern(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        size: Size(size(context).width, 200),
        painter: WavePatternPainter(_waveAnimation.value),
      ),
    );
  }

  // Build surface shimmer effect
  Widget _buildSurfaceShimmer(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.05),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

// Fish painter
class FishPainter extends CustomPainter {
  final Color color;

  FishPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Fish body
    final bodyPath = Path();
    bodyPath.moveTo(size.width * 0.7, size.height * 0.5);
    bodyPath.quadraticBezierTo(
      size.width * 0.5, size.height * 0.2,
      size.width * 0.2, size.height * 0.3,
    );
    bodyPath.quadraticBezierTo(
      0, size.height * 0.5,
      size.width * 0.2, size.height * 0.7,
    );
    bodyPath.quadraticBezierTo(
      size.width * 0.5, size.height * 0.8,
      size.width * 0.7, size.height * 0.5,
    );
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);

    // Fish tail
    final tailPath = Path();
    tailPath.moveTo(size.width * 0.7, size.height * 0.5);
    tailPath.lineTo(size.width, size.height * 0.2);
    tailPath.lineTo(size.width * 0.85, size.height * 0.5);
    tailPath.lineTo(size.width, size.height * 0.8);
    tailPath.close();

    canvas.drawPath(tailPath, paint);

    // Fish eye
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.4),
      size.width * 0.05,
      eyePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Underwater plants painter
class UnderwaterPlantsPainter extends CustomPainter {
  final double animationValue;

  UnderwaterPlantsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Draw multiple plants
    for (int i = 0; i < 8; i++) {
      double xPos = (size.width / 8) * i + (size.width / 16);
      double sway = sin(animationValue * 2 * pi + i) * 10;

      paint.color = Color(0xFF2D5016).withOpacity(0.6);

      final plantPath = Path();
      plantPath.moveTo(xPos, size.height);

      for (double y = size.height; y > size.height * 0.3; y -= 15) {
        double swayAmount = sway * (1 - y / size.height);
        plantPath.lineTo(xPos + swayAmount, y);
      }

      paint.strokeWidth = 8 + (i % 3) * 3;
      paint.style = PaintingStyle.stroke;
      paint.strokeCap = StrokeCap.round;

      canvas.drawPath(plantPath, paint);

      // Draw leaves
      paint.style = PaintingStyle.fill;
      for (double y = size.height - 20; y > size.height * 0.4; y -= 25) {
        double swayAmount = sway * (1 - y / size.height);

        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(xPos + swayAmount - 15, y),
            width: 20,
            height: 10,
          ),
          paint,
        );

        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(xPos + swayAmount + 15, y - 10),
            width: 20,
            height: 10,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Water ripple painter
class WaterRipplePainter extends CustomPainter {
  final double animationValue;

  WaterRipplePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      double radius = (animationValue + i * 0.33) % 1.0;
      paint.color = Colors.white.withOpacity(0.1 * (1 - radius));

      canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.3),
        radius * 150,
        paint,
      );

      canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.5),
        radius * 120,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Wave pattern painter
class WavePatternPainter extends CustomPainter {
  final double animationValue;

  WavePatternPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int layer = 0; layer < 4; layer++) {
      paint.color = Colors.white.withOpacity(0.08 - layer * 0.015);

      final path = Path();
      double yBase = 50 + layer * 30;
      double offset = animationValue * 80 * (layer % 2 == 0 ? 1 : -1);

      path.moveTo(0, yBase);

      for (double x = 0; x <= size.width; x += 10) {
        double y = yBase +
            15 * sin((x + offset) * 0.02) +
            8 * sin((x + offset) * 0.04);
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Enhanced wave pattern painter with shimmer effects
class EnhancedWavePatternPainter extends CustomPainter {
  final double animationValue;
  final double shimmerValue;
  final bool isTopArea;

  EnhancedWavePatternPainter(this.animationValue, this.shimmerValue, {required this.isTopArea});

  @override
  void paint(Canvas canvas, Size size) {
    // Multiple wave layers with different opacities
    final waveConfigs = [
      {'strokeWidth': 2.0, 'alpha': 0.08, 'frequency': 0.8},
      {'strokeWidth': 1.5, 'alpha': 0.06, 'frequency': 1.2},
      {'strokeWidth': 1.0, 'alpha': 0.04, 'frequency': 1.6},
    ];

    for (int layer = 0; layer < waveConfigs.length; layer++) {
      final config = waveConfigs[layer];
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: config['alpha']! + (shimmerValue * 0.02))
        ..strokeWidth = config['strokeWidth']!
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < 4; i++) {
        final path = Path();
        double baseYOffset = isTopArea
            ? size.height * 0.15 + (i * 30)
            : size.height * 0.5 + (i * 25);

        double waveOffset = animationValue * (isTopArea ? 40 : -40) * config['frequency']!;
        double amplitude = (8 + (i * 2)) * (layer + 1);

        path.moveTo(0, baseYOffset);

        for (double x = 0; x <= size.width; x += 10) {
          double y = baseYOffset +
              amplitude * sin((x + waveOffset) * 0.02 * config['frequency']!) +
              (amplitude * 0.3) * sin((x + waveOffset) * 0.05 * config['frequency']!);

          if (x == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }

        canvas.drawPath(path, paint);
      }
    }

    // Enhanced animated dots with glow
    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06 + (shimmerValue * 0.04))
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03 + (shimmerValue * 0.02))
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 12; i++) {
      double x = (size.width / 12) * i + (animationValue * (isTopArea ? 20 : -20));
      double y = isTopArea
          ? size.height * 0.25 + (i % 3) * 25 + (shimmerValue * 12)
          : size.height * 0.65 + (i % 3) * 20 + (shimmerValue * -12);

      double radius = 1.5 + (shimmerValue * 0.8);
      double glowRadius = radius * 3;

      if (x >= -glowRadius && x <= size.width + glowRadius) {
        // Draw glow
        canvas.drawCircle(Offset(x, y), glowRadius, glowPaint);
        // Draw dot
        canvas.drawCircle(Offset(x, y), radius, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// New shimmer effect painter
class ShimmerEffectPainter extends CustomPainter {
  final double animationValue;

  ShimmerEffectPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          Colors.white.withValues(alpha: 0.03 + (animationValue * 0.02)),
          Colors.transparent,
        ],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create diagonal shimmer bands
    for (int i = 0; i < 3; i++) {
      final path = Path();
      double bandWidth = 60;
      double spacing = 150;
      double x = -bandWidth + (animationValue * (size.width + bandWidth * 2)) - (i * spacing);

      path.moveTo(x, 0);
      path.lineTo(x + bandWidth, 0);
      path.lineTo(x + bandWidth + size.height * 0.3, size.height);
      path.lineTo(x + size.height * 0.3, size.height);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Light rays painter for connecting effects
class LightRaysPainter extends CustomPainter {
  final double animationValue;

  LightRaysPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04 + (animationValue * 0.02))
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw connecting rays between top and bottom purple areas
    for (int i = 0; i < 6; i++) {
      double startX = size.width * 0.1 + (i * size.width * 0.15);
      double startY = size.height * 0.3;
      double endX = size.width * 0.2 + (i * size.width * 0.12);
      double endY = size.height * 0.7;

      // Add some wave motion to the rays
      double midX = (startX + endX) / 2 + (20 * sin(animationValue * 6.28 + i));
      double midY = (startY + endY) / 2;

      final path = Path();
      path.moveTo(startX, startY);
      path.quadraticBezierTo(midX, midY, endX, endY);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Keep the original painters for the static shapes
class TopCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Orange accent layer
    final orangePaint = Paint()
      ..color = Color(0xFFFFA726);

    final orangePath = Path();
    orangePath.moveTo(size.width * 0.1, 0);
    orangePath.lineTo(size.width, 0);
    orangePath.lineTo(size.width, size.height * 0.40);
    orangePath.quadraticBezierTo(
      size.width * 0.9, size.height * 0.8,
      size.width * 0.2, size.height * 0.8,
    );
    orangePath.quadraticBezierTo(
      size.width * 0.35, size.height * 0.65,
      size.width * 0.3, size.height * 0.5,
    );
    orangePath.close();

    canvas.drawPath(orangePath, orangePaint);

    // Purple background
    final purplePaint = Paint()
      ..color = ColorRes.appColor;

    final purplePath = Path();
    purplePath.moveTo(0, 0);
    purplePath.lineTo(size.width, 0);
    purplePath.lineTo(size.width, size.height * 0.3);
    purplePath.quadraticBezierTo(
      size.width * 0.7, size.height * 0.6,
      size.width * 0.3, size.height * 0.8,
    );
    purplePath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.85,
      0, size.height * 0.7,
    );
    purplePath.close();

    canvas.drawPath(purplePath, purplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Orange accent layer
    final orangePaint = Paint()
      ..color = Color(0xFFFFA726);

    final orangePath = Path();
    orangePath.moveTo(0, size.height);
    orangePath.lineTo(size.width, size.height);
    orangePath.lineTo(size.width, size.height * 0.7);
    orangePath.quadraticBezierTo(
      size.width * 0.9, size.height * 0.1,
      size.width * 0.2, size.height * 0.7,
    );
    orangePath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.15,
      0, size.height * 0.1,
    );
    orangePath.close();

    canvas.drawPath(orangePath, orangePaint);

    // Purple background
    final purplePaint = Paint()
      ..color = ColorRes.appColor;

    final purplePath = Path();
    purplePath.moveTo(0, size.height);
    purplePath.lineTo(size.width, size.height);
    purplePath.lineTo(size.width, size.height * 0.9);
    purplePath.quadraticBezierTo(
      size.width * 0.5, size.height * 0.4,
      size.width * 0.8, size.height * 0.7,
    );
    purplePath.quadraticBezierTo(
      size.width * 0.1, size.height * 0.12,
      0, size.height * 0.5,
    );
    purplePath.close();

    canvas.drawPath(purplePath, purplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Normal Animation

// class AuthBackGroundCom extends StatefulWidget {
//   final List<Widget> children;
//   const AuthBackGroundCom({
//     super.key,
//     this.children = const <Widget>[]
//   });
//
//   @override
//   State<AuthBackGroundCom> createState() => _AuthBackGroundComState();
// }
//
// class _AuthBackGroundComState extends State<AuthBackGroundCom>
//     with TickerProviderStateMixin {
//
//   late AnimationController _floatingController;
//   late AnimationController _rotationController;
//   late AnimationController _pulseController;
//   late AnimationController _waveController;
//
//   late Animation<double> _floatingAnimation;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _pulseAnimation;
//   late Animation<double> _waveAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Floating animation for bubbles
//     _floatingController = AnimationController(
//       duration: Duration(seconds: 3),
//       vsync: this,
//     );
//     _floatingAnimation = Tween<double>(
//       begin: -10,
//       end: 10,
//     ).animate(CurvedAnimation(
//       parent: _floatingController,
//       curve: Curves.easeInOut,
//     ));
//
//     // Rotation animation for abstract shapes
//     _rotationController = AnimationController(
//       duration: Duration(seconds: 8),
//       vsync: this,
//     );
//     _rotationAnimation = Tween<double>(
//       begin: 0,
//       end: 2,
//     ).animate(CurvedAnimation(
//       parent: _rotationController,
//       curve: Curves.linear,
//     ));
//
//     // Pulse animation for circles
//     _pulseController = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );
//     _pulseAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.2,
//     ).animate(CurvedAnimation(
//       parent: _pulseController,
//       curve: Curves.easeInOut,
//     ));
//
//     // Wave animation
//     _waveController = AnimationController(
//       duration: Duration(seconds: 4),
//       vsync: this,
//     );
//     _waveAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _waveController,
//       curve: Curves.linear,
//     ));
//
//     // Start all animations
//     _floatingController.repeat(reverse: true);
//     _rotationController.repeat();
//     _pulseController.repeat(reverse: true);
//     _waveController.repeat();
//   }
//
//   @override
//   void dispose() {
//     _floatingController.dispose();
//     _rotationController.dispose();
//     _pulseController.dispose();
//     _waveController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (authController) {
//       return GlobalContainer(
//         height: size(context).height,
//         width: size(context).width,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             // Background with curved shapes
//             Container(
//               height: size(context).height,
//               width: size(context).width,
//               color: Colors.white,
//             ),
//
//             // Top purple curved shape (static)
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: CustomPaint(
//                 size: Size(size(context).width, size(context).height * 0.3),
//                 painter: TopCurvePainter(),
//               ),
//             ),
//
//             // Bottom purple curved shape (static)
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: CustomPaint(
//                 size: Size(size(context).width, size(context).height * 0.25),
//                 painter: BottomCurvePainter(),
//               ),
//             ),
//
//             // Animation effects only on purple areas
//             _buildAnimationEffects(context),
//
//             // Main content
//             Positioned(
//               left: 10, right: 10, bottom: 0, top: 0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: widget.children,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildAnimationEffects(BuildContext context) {
//     return AnimatedBuilder(
//       animation: Listenable.merge([
//         _floatingAnimation,
//         _rotationAnimation,
//         _pulseAnimation,
//         _waveAnimation,
//       ]),
//       builder: (context, child) => Stack(
//         children: [
//           // Top purple area animations
//           ..._buildTopAreaAnimations(context),
//           // Bottom purple area animations
//           ..._buildBottomAreaAnimations(context),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildTopAreaAnimations(BuildContext context) {
//     return [
//       // Large floating bubble in top purple area
//       Positioned(
//         top: 30 + _floatingAnimation.value,
//         right: 40,
//         child: Transform.scale(
//           scale: _pulseAnimation.value,
//           child: Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.2),
//                   Colors.white.withValues(alpha: 0.1),
//                   Colors.transparent,
//                 ],
//                 stops: [0.0, 0.7, 1.0],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       // Medium floating bubble in top area
//       Positioned(
//         top: 80 + (_floatingAnimation.value * 0.7),
//         left: 30,
//         child: Transform.scale(
//           scale: _pulseAnimation.value * 0.8,
//           child: Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.15),
//                   Colors.white.withValues(alpha: 0.08),
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       // Small floating bubbles in top area
//       ...List.generate(3, (index) => Positioned(
//         top: 50 + (index * 25) + (_floatingAnimation.value * (index % 2 == 0 ? 1 : -1)),
//         left: 60 + (index * 40),
//         child: Transform.scale(
//           scale: _pulseAnimation.value * (0.6 + index * 0.1),
//           child: Container(
//             width: 30 + (index * 5),
//             height: 30 + (index * 5),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white.withValues(alpha: 0.12 - (index * 0.02)),
//             ),
//           ),
//         ),
//       )),
//
//       // Rotating shapes in top purple area
//       ...List.generate(3, (index) => Positioned(
//         top: 40 + (index * 30),
//         right: 80 + (index * 60),
//         child: Transform.rotate(
//           angle: _rotationAnimation.value * 3.14159 + (index * 0.5),
//           child: Container(
//             width: 20 + (index * 5),
//             height: 20 + (index * 5),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               color: Colors.white.withValues(alpha: 0.1 - (index * 0.02)),
//             ),
//           ),
//         ),
//       )),
//
//       // Wave patterns in top area
//       Positioned(
//         top: 0,
//         left: 0,
//         right: 0,
//         child: Container(
//           height: size(context).height * 0.3,
//           child: CustomPaint(
//             painter: AnimatedWavePatternPainter(
//               _waveAnimation.value,
//               isTopArea: true,
//             ),
//           ),
//         ),
//       ),
//     ];
//   }
//
//   List<Widget> _buildBottomAreaAnimations(BuildContext context) {
//     return [
//       // Large floating bubble in bottom purple area
//       Positioned(
//         bottom: 40 + (_floatingAnimation.value * -1),
//         left: 50,
//         child: Transform.scale(
//           scale: _pulseAnimation.value * 0.9,
//           child: Container(
//             width: 70,
//             height: 70,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.18),
//                   Colors.white.withValues(alpha: 0.09),
//                   Colors.transparent,
//                 ],
//                 stops: [0.0, 0.7, 1.0],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       // Medium floating bubble in bottom area
//       Positioned(
//         bottom: 80 + (_floatingAnimation.value * 0.5),
//         right: 60,
//         child: Transform.scale(
//           scale: _pulseAnimation.value * 0.7,
//           child: Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.14),
//                   Colors.white.withValues(alpha: 0.07),
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//
//       // Small floating bubbles in bottom area
//       ...List.generate(4, (index) => Positioned(
//         bottom: 50 + (index * 20) + (_floatingAnimation.value * (index % 2 == 0 ? -1 : 1)),
//         right: 40 + (index * 50),
//         child: Transform.scale(
//           scale: _pulseAnimation.value * (0.5 + index * 0.1),
//           child: Container(
//             width: 25 + (index * 3),
//             height: 25 + (index * 3),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white.withValues(alpha: 0.1 - (index * 0.015)),
//             ),
//           ),
//         ),
//       )),
//
//       // Rotating shapes in bottom purple area
//       ...List.generate(3, (index) => Positioned(
//         bottom: 60 + (index * 25),
//         left: 80 + (index * 70),
//         child: Transform.rotate(
//           angle: _rotationAnimation.value * -3.14159 + (index * 0.7),
//           child: Container(
//             width: 18 + (index * 4),
//             height: 18 + (index * 4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: Colors.white.withValues(alpha: 0.08 - (index * 0.015)),
//             ),
//           ),
//         ),
//       )),
//
//       // Wave patterns in bottom area
//       Positioned(
//         bottom: 0,
//         left: 0,
//         right: 0,
//         child: Container(
//           height: size(context).height * 0.25,
//           child: CustomPaint(
//             painter: AnimatedWavePatternPainter(
//               _waveAnimation.value,
//               isTopArea: false,
//             ),
//           ),
//         ),
//       ),
//     ];
//   }
// }
//
// // Original static painter for top curved shape
// class TopCurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Orange accent layer
//     final orangePaint = Paint()
//       ..color = Color(0xFFFFA726);
//
//     final orangePath = Path();
//     orangePath.moveTo(size.width * 0.1, 0);
//     orangePath.lineTo(size.width, 0);
//     orangePath.lineTo(size.width, size.height * 0.40);
//     orangePath.quadraticBezierTo(
//       size.width * 0.9, size.height * 0.8,
//       size.width * 0.2, size.height * 0.8,
//     );
//     orangePath.quadraticBezierTo(
//       size.width * 0.35, size.height * 0.65,
//       size.width * 0.3, size.height * 0.5,
//     );
//     orangePath.close();
//
//     canvas.drawPath(orangePath, orangePaint);
//
//     // Purple background
//     final purplePaint = Paint()
//       ..color = ColorRes.appColor;
//
//     final purplePath = Path();
//     purplePath.moveTo(0, 0);
//     purplePath.lineTo(size.width, 0);
//     purplePath.lineTo(size.width, size.height * 0.3);
//     purplePath.quadraticBezierTo(
//       size.width * 0.7, size.height * 0.6,
//       size.width * 0.3, size.height * 0.8,
//     );
//     purplePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.85,
//       0, size.height * 0.7,
//     );
//     purplePath.close();
//
//     canvas.drawPath(purplePath, purplePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // Original static painter for bottom curved shape
// class BottomCurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Orange accent layer
//     final orangePaint = Paint()
//       ..color = Color(0xFFFFA726);
//
//     final orangePath = Path();
//     orangePath.moveTo(0, size.height);
//     orangePath.lineTo(size.width, size.height);
//     orangePath.lineTo(size.width, size.height * 0.7);
//     orangePath.quadraticBezierTo(
//       size.width * 0.9, size.height * 0.1,
//       size.width * 0.2, size.height * 0.7,
//     );
//     orangePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.15,
//       0, size.height * 0.1,
//     );
//     orangePath.close();
//
//     canvas.drawPath(orangePath, orangePaint);
//
//     // Purple background
//     final purplePaint = Paint()
//       ..color = ColorRes.appColor;
//
//     final purplePath = Path();
//     purplePath.moveTo(0, size.height);
//     purplePath.lineTo(size.width, size.height);
//     purplePath.lineTo(size.width, size.height * 0.9);
//     purplePath.quadraticBezierTo(
//       size.width * 0.5, size.height * 0.4,
//       size.width * 0.8, size.height * 0.7,
//     );
//     purplePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.12,
//       0, size.height * 0.5,
//     );
//     purplePath.close();
//
//     canvas.drawPath(purplePath, purplePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // Wave pattern painter for animation effects
// class AnimatedWavePatternPainter extends CustomPainter {
//   final double animationValue;
//   final bool isTopArea;
//
//   AnimatedWavePatternPainter(this.animationValue, {required this.isTopArea});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.06)
//       ..strokeWidth = 1.5
//       ..style = PaintingStyle.stroke;
//
//     // Create animated wave patterns
//     for (int i = 0; i < 3; i++) {
//       final path = Path();
//       double yOffset = isTopArea
//           ? size.height * 0.2 + (i * 25)
//           : size.height * 0.6 + (i * 20);
//       double waveOffset = animationValue * (isTopArea ? 30 : -30);
//
//       path.moveTo(0, yOffset);
//
//       for (double x = 0; x <= size.width; x += 15) {
//         double y = yOffset + (6 * (i + 1)) *
//             (0.5 + 0.5 * ((x + waveOffset) / size.width)) *
//             (1 + 0.2 * ((x + waveOffset) / 80));
//
//         if (x == 0) {
//           path.moveTo(x, y);
//         } else {
//           path.lineTo(x, y);
//         }
//       }
//
//       canvas.drawPath(path, paint);
//     }
//
//     // Add animated dots
//     final dotPaint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.05 + (animationValue * 0.02))
//       ..style = PaintingStyle.fill;
//
//     for (int i = 0; i < 8; i++) {
//       double x = (size.width / 8) * i + (animationValue * (isTopArea ? 15 : -15));
//       double y = isTopArea
//           ? size.height * 0.3 + (i % 2) * 20 + (animationValue * 8)
//           : size.height * 0.7 + (i % 2) * 15 + (animationValue * -8);
//       double radius = 1 + (animationValue * 0.3);
//
//       if (x >= 0 && x <= size.width) {
//         canvas.drawCircle(Offset(x, y), radius, dotPaint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

/// ==/@ Mobile Performance Animation Design Design

// class AuthBackGroundCom extends StatefulWidget {
//   final List<Widget> children;
//   final bool enableAnimations; // Performance control
//   final AnimationQuality quality; // Quality settings
//
//   const AuthBackGroundCom({
//     super.key,
//     this.children = const <Widget>[],
//     this.enableAnimations = true,
//     this.quality = AnimationQuality.high,
//   });
//
//   @override
//   State<AuthBackGroundCom> createState() => _AuthBackGroundComState();
// }
//
// enum AnimationQuality {
//   low,    // Minimal animations
//   medium, // Balanced performance
//   high,   // Full animations
// }
//
// class _AuthBackGroundComState extends State<AuthBackGroundCom>
//     with TickerProviderStateMixin {
//
//   late AnimationController _primaryController;
//   late AnimationController _secondaryController;
//   late AnimationController _tertiaryController;
//
//   late Animation<double> _primaryAnimation;
//   late Animation<double> _secondaryAnimation;
//   late Animation<double> _tertiaryAnimation;
//
//   // Performance monitoring
//   final bool _isLowPerformanceDevice = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkDevicePerformance();
//     _initializeAnimations();
//   }
//
//   void _checkDevicePerformance() {
//     // Simple performance check - you can enhance this
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   final mediaQuery = MediaQuery.of(context);
//     //   _isLowPerformanceDevice = mediaQuery.size.width < 400 ||
//     //                           mediaQuery.devicePixelRatio < 2.0;
//     // });
//   }
//
//   void _initializeAnimations() {
//     if (!widget.enableAnimations) return;
//
//     // Reduced to 3 controllers for better performance
//     _primaryController = AnimationController(
//       duration: Duration(seconds: _isLowPerformanceDevice ? 6 : 4),
//       vsync: this,
//     );
//
//     _secondaryController = AnimationController(
//       duration: Duration(seconds: _isLowPerformanceDevice ? 10 : 8),
//       vsync: this,
//     );
//
//     _tertiaryController = AnimationController(
//       duration: Duration(seconds: _isLowPerformanceDevice ? 8 : 6),
//       vsync: this,
//     );
//
//     // Combined animations for efficiency
//     _primaryAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _primaryController,
//       curve: Curves.easeInOutSine,
//     ));
//
//     _secondaryAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _secondaryController,
//       curve: Curves.linear,
//     ));
//
//     _tertiaryAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _tertiaryController,
//       curve: Curves.easeInOutCubic,
//     ));
//
//     // Start animations
//     _primaryController.repeat(reverse: true);
//     _secondaryController.repeat();
//     _tertiaryController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _primaryController.dispose();
//     _secondaryController.dispose();
//     _tertiaryController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (authController) {
//       return GlobalContainer(
//         height: size(context).height,
//         width: size(context).width,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             // Static background
//             Container(
//               height: size(context).height,
//               width: size(context).width,
//               color: Colors.white,
//             ),
//
//             // Static curved shapes
//             _buildStaticShapes(context),
//
//             // Conditional animations based on performance
//             if (widget.enableAnimations) _buildOptimizedAnimations(context),
//
//             // Main content
//             Positioned(
//               left: 10, right: 10, bottom: 0, top: 0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: widget.children,
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildStaticShapes(BuildContext context) {
//     return Stack(
//       children: [
//         // Top purple curved shape
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: CustomPaint(
//             size: Size(size(context).width, size(context).height * 0.3),
//             painter: TopCurvePainter(),
//           ),
//         ),
//
//         // Bottom purple curved shape
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: CustomPaint(
//             size: Size(size(context).width, size(context).height * 0.25),
//             painter: BottomCurvePainter(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildOptimizedAnimations(BuildContext context) {
//     switch (widget.quality) {
//       case AnimationQuality.low:
//         return _buildLowQualityAnimations(context);
//       case AnimationQuality.medium:
//         return _buildMediumQualityAnimations(context);
//       case AnimationQuality.high:
//         return _buildHighQualityAnimations(context);
//     }
//   }
//
//   Widget _buildLowQualityAnimations(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _primaryAnimation,
//       builder: (context, child) => Stack(
//         children: [
//           // Only essential floating bubbles
//           ..._buildEssentialBubbles(context, 3), // Reduced count
//
//           // Simple wave pattern
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: CustomPaint(
//               painter: SimpleWavePainter(_primaryAnimation.value, true),
//             ),
//           ),
//
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: CustomPaint(
//               painter: SimpleWavePainter(_primaryAnimation.value, false),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMediumQualityAnimations(BuildContext context) {
//     return AnimatedBuilder(
//       animation: Listenable.merge([_primaryAnimation, _secondaryAnimation]),
//       builder: (context, child) => Stack(
//         children: [
//           // Moderate number of bubbles
//           ..._buildEssentialBubbles(context, 6),
//
//           // Enhanced wave patterns
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: CustomPaint(
//               painter: MediumWavePainter(
//                 _primaryAnimation.value,
//                 _secondaryAnimation.value,
//                 true,
//               ),
//             ),
//           ),
//
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: CustomPaint(
//               painter: MediumWavePainter(
//                 _primaryAnimation.value,
//                 _secondaryAnimation.value,
//                 false,
//               ),
//             ),
//           ),
//
//           // Light floating particles
//           ..._buildOptimizedParticles(context, 8),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHighQualityAnimations(BuildContext context) {
//     return AnimatedBuilder(
//       animation: Listenable.merge([
//         _primaryAnimation,
//         _secondaryAnimation,
//         _tertiaryAnimation,
//       ]),
//       builder: (context, child) => Stack(
//         children: [
//           // Full bubble effects
//           ..._buildEssentialBubbles(context, 10),
//
//           // Full wave patterns
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: CustomPaint(
//               painter: HighQualityWavePainter(
//                 _primaryAnimation.value,
//                 _secondaryAnimation.value,
//                 _tertiaryAnimation.value,
//                 true,
//               ),
//             ),
//           ),
//
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: CustomPaint(
//               painter: HighQualityWavePainter(
//                 _primaryAnimation.value,
//                 _secondaryAnimation.value,
//                 _tertiaryAnimation.value,
//                 false,
//               ),
//             ),
//           ),
//
//           // Full particle system
//           ..._buildOptimizedParticles(context, 15),
//
//           // Shimmer effect (high quality only)
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: CustomPaint(
//               painter: OptimizedShimmerPainter(_tertiaryAnimation.value),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildEssentialBubbles(BuildContext context, int count) {
//     return List.generate(count, (index) {
//       double floatingOffset = (_primaryAnimation.value * 2 - 1) * 15;
//       double pulseScale = 0.8 + (_tertiaryAnimation.value * 0.4);
//
//       bool isTopArea = index < count / 2;
//
//       return Positioned(
//         top: isTopArea ? 40 + (index * 40) + floatingOffset : null,
//         bottom: !isTopArea ? 40 + ((index - count ~/ 2) * 40) - floatingOffset : null,
//         left: (40 + (index * 60) % (size(context).width - 100)).toDouble(),
//         child: Transform.scale(
//           scale: pulseScale,
//           child: Container(
//             width: 60 + (index % 3) * 20,
//             height: 60 + (index % 3) * 20,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               gradient: RadialGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.2 - (index * 0.02)),
//                   Colors.white.withValues(alpha: 0.1 - (index * 0.01)),
//                   Colors.transparent,
//                 ],
//                 stops: [0.0, 0.6, 1.0],
//               ),
//               // Conditional shadow for performance
//               boxShadow: widget.quality == AnimationQuality.high ? [
//                 BoxShadow(
//                   color: Colors.white.withValues(alpha: 0.1),
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                 ),
//               ] : null,
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//   List<Widget> _buildOptimizedParticles(BuildContext context, int count) {
//     return List.generate(count, (index) {
//       double animationOffset = (index * 0.3) % 1.0;
//       double adjustedAnimation = (_secondaryAnimation.value + animationOffset) % 1.0;
//
//       return Positioned(
//         left: (size(context).width * 0.1) + (index * size(context).width * 0.06),
//         top: size(context).height * 0.2 + (adjustedAnimation * size(context).height * 0.6),
//         child: Container(
//           width: 3 + (index % 3),
//           height: 3 + (index % 3),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white.withValues(alpha: 0.1 - (adjustedAnimation * 0.05)),
//           ),
//         ),
//       );
//     });
//   }
// }
//
// // Optimized painters with reduced complexity
// class SimpleWavePainter extends CustomPainter {
//   final double animationValue;
//   final bool isTopArea;
//
//   SimpleWavePainter(this.animationValue, this.isTopArea);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white.withValues(alpha: 0.06)
//       ..strokeWidth = 1.0
//       ..style = PaintingStyle.stroke;
//
//     final path = Path();
//     double yOffset = isTopArea ? size.height * 0.2 : size.height * 0.7;
//     double waveOffset = animationValue * 40;
//
//     path.moveTo(0, yOffset);
//     for (double x = 0; x <= size.width; x += 20) {
//       double y = yOffset + 8 * sin((x + waveOffset) * 0.02);
//       path.lineTo(x, y);
//     }
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
// class MediumWavePainter extends CustomPainter {
//   final double primaryValue;
//   final double secondaryValue;
//   final bool isTopArea;
//
//   MediumWavePainter(this.primaryValue, this.secondaryValue, this.isTopArea);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Two wave layers
//     for (int layer = 0; layer < 2; layer++) {
//       final paint = Paint()
//         ..color = Colors.white.withValues(alpha: 0.05 - (layer * 0.01))
//         ..strokeWidth = 1.5 - (layer * 0.3)
//         ..style = PaintingStyle.stroke;
//
//       final path = Path();
//       double yOffset = isTopArea ? size.height * 0.2 + (layer * 25) : size.height * 0.7 + (layer * 20);
//       double waveOffset = (layer == 0 ? primaryValue : secondaryValue) * 40;
//
//       path.moveTo(0, yOffset);
//       for (double x = 0; x <= size.width; x += 15) {
//         double y = yOffset + (6 + layer * 2) * sin((x + waveOffset) * 0.02);
//         path.lineTo(x, y);
//       }
//
//       canvas.drawPath(path, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
// class HighQualityWavePainter extends CustomPainter {
//   final double primaryValue;
//   final double secondaryValue;
//   final double tertiaryValue;
//   final bool isTopArea;
//
//   HighQualityWavePainter(this.primaryValue, this.secondaryValue, this.tertiaryValue, this.isTopArea);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Three wave layers with complex patterns
//     final animations = [primaryValue, secondaryValue, tertiaryValue];
//
//     for (int layer = 0; layer < 3; layer++) {
//       final paint = Paint()
//         ..color = Colors.white.withValues(alpha: 0.06 - (layer * 0.015))
//         ..strokeWidth = 2.0 - (layer * 0.3)
//         ..style = PaintingStyle.stroke;
//
//       final path = Path();
//       double yOffset = isTopArea ? size.height * 0.15 + (layer * 30) : size.height * 0.6 + (layer * 25);
//       double waveOffset = animations[layer] * (40 + layer * 10);
//
//       path.moveTo(0, yOffset);
//       for (double x = 0; x <= size.width; x += 10) {
//         double y = yOffset +
//             (8 + layer * 2) * sin((x + waveOffset) * 0.02) +
//             (4 + layer) * sin((x + waveOffset) * 0.05);
//         path.lineTo(x, y);
//       }
//
//       canvas.drawPath(path, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
// class OptimizedShimmerPainter extends CustomPainter {
//   final double animationValue;
//
//   OptimizedShimmerPainter(this.animationValue);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..shader = LinearGradient(
//         colors: [
//           Colors.transparent,
//           Colors.white.withValues(alpha: 0.02 + (animationValue * 0.01)),
//           Colors.transparent,
//         ],
//         stops: [0.0, 0.5, 1.0],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
//
//     // Single shimmer band for better performance
//     final path = Path();
//     double bandWidth = 80;
//     double x = -bandWidth + (animationValue * (size.width + bandWidth * 2));
//
//     path.moveTo(x, 0);
//     path.lineTo(x + bandWidth, 0);
//     path.lineTo(x + bandWidth + size.height * 0.2, size.height);
//     path.lineTo(x + size.height * 0.2, size.height);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
// // Keep original painters
// class TopCurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final orangePaint = Paint()..color = Color(0xFFFFA726);
//     final orangePath = Path();
//     orangePath.moveTo(size.width * 0.1, 0);
//     orangePath.lineTo(size.width, 0);
//     orangePath.lineTo(size.width, size.height * 0.40);
//     orangePath.quadraticBezierTo(
//       size.width * 0.9, size.height * 0.8,
//       size.width * 0.2, size.height * 0.8,
//     );
//     orangePath.quadraticBezierTo(
//       size.width * 0.35, size.height * 0.65,
//       size.width * 0.3, size.height * 0.5,
//     );
//     orangePath.close();
//     canvas.drawPath(orangePath, orangePaint);
//
//     final purplePaint = Paint()..color = ColorRes.appColor;
//     final purplePath = Path();
//     purplePath.moveTo(0, 0);
//     purplePath.lineTo(size.width, 0);
//     purplePath.lineTo(size.width, size.height * 0.3);
//     purplePath.quadraticBezierTo(
//       size.width * 0.7, size.height * 0.6,
//       size.width * 0.3, size.height * 0.8,
//     );
//     purplePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.85,
//       0, size.height * 0.7,
//     );
//     purplePath.close();
//     canvas.drawPath(purplePath, purplePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class BottomCurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final orangePaint = Paint()..color = Color(0xFFFFA726);
//     final orangePath = Path();
//     orangePath.moveTo(0, size.height);
//     orangePath.lineTo(size.width, size.height);
//     orangePath.lineTo(size.width, size.height * 0.7);
//     orangePath.quadraticBezierTo(
//       size.width * 0.9, size.height * 0.1,
//       size.width * 0.2, size.height * 0.7,
//     );
//     orangePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.15,
//       0, size.height * 0.1,
//     );
//     orangePath.close();
//     canvas.drawPath(orangePath, orangePaint);
//
//     final purplePaint = Paint()..color = ColorRes.appColor;
//     final purplePath = Path();
//     purplePath.moveTo(0, size.height);
//     purplePath.lineTo(size.width, size.height);
//     purplePath.lineTo(size.width, size.height * 0.9);
//     purplePath.quadraticBezierTo(
//       size.width * 0.5, size.height * 0.4,
//       size.width * 0.8, size.height * 0.7,
//     );
//     purplePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.12,
//       0, size.height * 0.5,
//     );
//     purplePath.close();
//     canvas.drawPath(purplePath, purplePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

/// ==/@ Static Design

// class AuthBackGroundCom extends StatefulWidget {
//   final List<Widget> children;
//   const AuthBackGroundCom({
//     super.key,
//     this.children = const <Widget>[]
//   });
//
//   @override
//   State<AuthBackGroundCom> createState() => _AuthBackGroundComState();
// }
//
// class _AuthBackGroundComState extends State<AuthBackGroundCom> {
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (authController) {
//       return GlobalContainer(
//         height: size(context).height,
//         width: size(context).width,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             // Background with curved shapes
//             Container(
//               height: size(context).height,
//               width: size(context).width,
//               color: Colors.white,
//             ),
//
//             // Top purple curved shape
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: CustomPaint(
//                 size: Size(size(context).width, size(context).height * 0.3),
//                 painter: TopCurvePainter(),
//               ),
//             ),
//
//             // Bottom purple curved shape
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: CustomPaint(
//                 size: Size(size(context).width, size(context).height * 0.25),
//                 painter: BottomCurvePainter(),
//               ),
//             ),
//
//             // Main content
//             Positioned(
//               left: 10, right: 10, bottom: 0, top: 0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: widget.children,
//               ),
//             ),
//
//           ],
//         ),
//       );
//     });
//   }
// }
//
// // Custom painter for top curved shape with orange accent
// class TopCurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//
//     // Orange accent layer
//     final orangePaint = Paint()
//       ..color = Color(0xFFFFA726);
//
//     final orangePath = Path();
//     orangePath.moveTo(size.width * 0.1, 0);
//     orangePath.lineTo(size.width, 0);
//     orangePath.lineTo(size.width, size.height * 0.40);
//     orangePath.quadraticBezierTo(
//       size.width * 0.9, size.height * 0.8,
//       size.width * 0.2, size.height * 0.8,
//     );
//     orangePath.quadraticBezierTo(
//       size.width * 0.35, size.height * 0.65,
//       size.width * 0.3, size.height * 0.5,
//     );
//     orangePath.close();
//
//     canvas.drawPath(orangePath, orangePaint);
//
//     // Purple background
//     final purplePaint = Paint()
//       ..color = ColorRes.appColor;
//
//     final purplePath = Path();
//     purplePath.moveTo(0, 0);
//     purplePath.lineTo(size.width, 0);
//     purplePath.lineTo(size.width, size.height * 0.3);
//     purplePath.quadraticBezierTo(
//       size.width * 0.7, size.height * 0.6,
//       size.width * 0.3, size.height * 0.8,
//     );
//     purplePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.85,
//       0, size.height * 0.7,
//     );
//     purplePath.close();
//
//     canvas.drawPath(purplePath, purplePaint);
//
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // Custom painter for bottom curved shape with orange accent
// class BottomCurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//
//
//     // Orange accent layer
//     final orangePaint = Paint()
//       ..color = Color(0xFFFFA726);
//
//     final orangePath = Path();
//     orangePath.moveTo(0, size.height);
//     orangePath.lineTo(size.width, size.height);
//     orangePath.lineTo(size.width, size.height * 0.7);
//     orangePath.quadraticBezierTo(
//       size.width * 0.9, size.height * 0.1,
//       size.width * 0.2, size.height * 0.7,
//     );
//     orangePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.15,
//       0, size.height * 0.1,
//     );
//     orangePath.close();
//
//     canvas.drawPath(orangePath, orangePaint);
//
//     // Purple background
//     final purplePaint = Paint()
//       ..color = ColorRes.appColor;
//
//     final purplePath = Path();
//     purplePath.moveTo(0, size.height);
//     purplePath.lineTo(size.width, size.height);
//     purplePath.lineTo(size.width, size.height * 0.9);
//     purplePath.quadraticBezierTo(
//       size.width * 0.5, size.height * 0.4,
//       size.width * 0.8, size.height * 0.7,
//     );
//     purplePath.quadraticBezierTo(
//       size.width * 0.1, size.height * 0.12,
//       0, size.height * 0.5,
//     );
//     purplePath.close();
//
//     canvas.drawPath(purplePath, purplePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
