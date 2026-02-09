import 'package:flutter/material.dart';
import '../app_theme.dart';

class ScrollProgressIndicator extends StatefulWidget {
  final ScrollController scrollController;

  const ScrollProgressIndicator({
    super.key,
    required this.scrollController,
  });

  @override
  State<ScrollProgressIndicator> createState() => _ScrollProgressIndicatorState();
}

class _ScrollProgressIndicatorState extends State<ScrollProgressIndicator> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateProgress);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    if (!widget.scrollController.hasClients) return;
    
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    final progress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
    
    if (progress != _progress) {
      setState(() => _progress = progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    const barHeight = 3.0;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: barHeight,
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.12),
        ),
        child: FractionallySizedBox(
          widthFactor: _progress.clamp(0.0, 1.0),
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(barHeight / 2),
            ),
          ),
        ),
      ),
    );
  }
}
