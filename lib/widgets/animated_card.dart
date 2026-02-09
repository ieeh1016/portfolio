import 'package:flutter/material.dart';
import '../app_theme.dart';

/// 호버/탭 효과가 있는 애니메이션 카드
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool useGradient;

  const AnimatedCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.useGradient = false,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: double.infinity,
            padding: widget.padding ?? const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: widget.useGradient ? AppTheme.heroGradient : null,
              color: widget.useGradient ? null : AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isHovered ? AppTheme.cardShadowHover : AppTheme.cardShadow,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
