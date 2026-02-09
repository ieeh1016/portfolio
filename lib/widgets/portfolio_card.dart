import 'package:flutter/material.dart';
import 'animated_card.dart';

class PortfolioCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool useGradient;

  const PortfolioCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.useGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      padding: padding,
      onTap: onTap,
      useGradient: useGradient,
      child: child,
    );
  }
}
