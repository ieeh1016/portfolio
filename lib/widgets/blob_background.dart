import 'package:flutter/material.dart';
import '../app_theme.dart';

/// 브루탈 스타일: 단색 + 미세 그리드 라인 (블롭/그라데이션 제거)
class BlobBackground extends StatelessWidget {
  final Widget child;

  const BlobBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: _MinimalGridPainter(),
          size: Size.infinite,
        ),
        child,
      ],
    );
  }
}

class _MinimalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = AppTheme.background);
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.04)
      ..strokeWidth = 1;
    const step = 48.0;
    for (double x = 0; x <= size.width + step; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height + step; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MinimalGridPainter oldDelegate) => false;
}
