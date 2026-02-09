import 'package:flutter/material.dart';
import '../app_theme.dart';

class BlobBackground extends StatefulWidget {
  final Widget child;

  const BlobBackground({super.key, required this.child});

  @override
  State<BlobBackground> createState() => _BlobBackgroundState();
}

class _BlobBackgroundState extends State<BlobBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _controller2 = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();
    _controller3 = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Stack(
      children: [
        AnimatedBuilder(
          animation: Listenable.merge([_controller1, _controller2, _controller3]),
          builder: (context, child) {
            return CustomPaint(
              painter: BlobPainter(
                animation1: _controller1.value,
                animation2: _controller2.value,
                animation3: _controller3.value,
                isDark: isDark,
              ),
              size: Size.infinite,
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class BlobPainter extends CustomPainter {
  final double animation1;
  final double animation2;
  final double animation3;
  final bool isDark;

  BlobPainter({
    required this.animation1,
    required this.animation2,
    required this.animation3,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..shader = RadialGradient(
        colors: isDark
            ? [
                AppTheme.primary.withOpacity(0.15),
                AppTheme.primary.withOpacity(0.05),
              ]
            : [
                AppTheme.primary.withOpacity(0.2),
                AppTheme.primary.withOpacity(0.05),
              ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * 0.2 + (animation1 * 100),
            size.height * 0.3 + (animation2 * 80),
          ),
          radius: 200,
        ),
      );

    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: isDark
            ? [
                AppTheme.secondary.withOpacity(0.15),
                AppTheme.secondary.withOpacity(0.05),
              ]
            : [
                AppTheme.secondary.withOpacity(0.2),
                AppTheme.secondary.withOpacity(0.05),
              ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * 0.8 - (animation2 * 100),
            size.height * 0.5 + (animation3 * 100),
          ),
          radius: 250,
        ),
      );

    final paint3 = Paint()
      ..shader = RadialGradient(
        colors: isDark
            ? [
                AppTheme.accent.withOpacity(0.1),
                AppTheme.accent.withOpacity(0.03),
              ]
            : [
                AppTheme.accent.withOpacity(0.15),
                AppTheme.accent.withOpacity(0.03),
              ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * 0.5 + (animation3 * 120),
            size.height * 0.7 - (animation1 * 90),
          ),
          radius: 180,
        ),
      );

    canvas.drawCircle(
      Offset(
        size.width * 0.2 + (animation1 * 100),
        size.height * 0.3 + (animation2 * 80),
      ),
      200,
      paint1,
    );

    canvas.drawCircle(
      Offset(
        size.width * 0.8 - (animation2 * 100),
        size.height * 0.5 + (animation3 * 100),
      ),
      250,
      paint2,
    );

    canvas.drawCircle(
      Offset(
        size.width * 0.5 + (animation3 * 120),
        size.height * 0.7 - (animation1 * 90),
      ),
      180,
      paint3,
    );
  }

  @override
  bool shouldRepaint(BlobPainter oldDelegate) {
    return oldDelegate.animation1 != animation1 ||
        oldDelegate.animation2 != animation2 ||
        oldDelegate.animation3 != animation3 ||
        oldDelegate.isDark != isDark;
  }
}
