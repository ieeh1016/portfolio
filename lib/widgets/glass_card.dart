import 'dart:ui';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool useGlow;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.useGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: useGlow
            ? [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : AppTheme.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            padding: padding ?? const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: (isDark ? AppTheme.darkSurface : AppTheme.surface).withOpacity(0.85),
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : AppTheme.primary.withOpacity(0.12),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
