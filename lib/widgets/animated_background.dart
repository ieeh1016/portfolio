import 'package:flutter/material.dart';
import '../app_theme.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                -1 + (_animation.value * 2),
                -1 + (_animation.value * 2),
              ),
              end: Alignment(
                1 - (_animation.value * 2),
                1 - (_animation.value * 2),
              ),
              colors: [
                AppTheme.background,
                AppTheme.background.withOpacity(0.8),
                AppTheme.primaryLight.withOpacity(0.1),
                AppTheme.background,
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
