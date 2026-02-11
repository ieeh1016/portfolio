import 'package:flutter/material.dart';
import '../app_theme.dart';

/// 최초 진입 시 깔끔한 로딩 바
class LoadingScreen extends StatefulWidget {
  final Widget child;
  final Duration minDisplayDuration;

  const LoadingScreen({
    super.key,
    required this.child,
    this.minDisplayDuration = const Duration(milliseconds: 1200),
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();
    Future.delayed(widget.minDisplayDuration, () {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_ready) return widget.child;

    return Material(
      color: AppTheme.background,
      child: Center(
        child: SizedBox(
          width: 200,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: CustomPaint(
                  size: const Size(200, 3),
                  painter: _LoadingBarPainter(
                    progress: _controller.value,
                    trackColor: AppTheme.primary.withValues(alpha: 0.12),
                    barColor: AppTheme.primary,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LoadingBarPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color barColor;

  _LoadingBarPainter({
    required this.progress,
    required this.trackColor,
    required this.barColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final track = Paint()..color = trackColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), track);

    const barWidth = 60.0;
    final x = (progress * (size.width + barWidth)) - barWidth;
    final left = x.clamp(0.0, size.width);
    final right = (x + barWidth).clamp(0.0, size.width);
    if (right > left) {
      final bar = Paint()..color = barColor;
      canvas.drawRect(Rect.fromLTRB(left, 0, right, size.height), bar);
    }
  }

  @override
  bool shouldRepaint(covariant _LoadingBarPainter old) => old.progress != progress;
}
