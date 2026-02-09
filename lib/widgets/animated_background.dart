import 'package:flutter/material.dart';

/// 브루탈 스타일: 배경 애니메이션 제거, 자식만 전달
class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}
