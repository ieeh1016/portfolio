import 'package:flutter/material.dart';
import '../app_theme.dart';

class ThemeToggle extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onToggle;

  const ThemeToggle({
    super.key,
    required this.isDark,
    required this.onToggle,
  });

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.isDark) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(ThemeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDark != widget.isDark) {
      if (widget.isDark) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onToggle(!widget.isDark),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: RotationTransition(
          turns: _rotationAnimation,
          child: Icon(
            widget.isDark ? Icons.dark_mode : Icons.light_mode,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
