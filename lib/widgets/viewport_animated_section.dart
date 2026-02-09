import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 뷰포트 기반 스크롤 애니메이션 섹션
class ViewportAnimatedSection extends StatefulWidget {
  final Widget child;
  final Curve curve;
  final double threshold;

  const ViewportAnimatedSection({
    super.key,
    required this.child,
    this.curve = Curves.easeOutCubic,
    this.threshold = 0.2,
  });

  @override
  State<ViewportAnimatedSection> createState() => _ViewportAnimatedSectionState();
}

class _ViewportAnimatedSectionState extends State<ViewportAnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: widget.curve),
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.8, curve: widget.curve),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_hasAnimated || !mounted) return;

    final context = this.context;
    final renderObject = context.findRenderObject();
    if (renderObject == null || !renderObject.attached) return;

    final viewport = RenderAbstractViewport.maybeOf(renderObject);
    if (viewport == null) return;

    final renderBox = renderObject as RenderBox;
    final size = renderBox.size;
    if (size.height <= 0) return;

    final viewportBox = viewport is RenderBox ? viewport as RenderBox : null;
    if (viewportBox == null) return;
    final viewportSize = viewportBox.size;

    final revealed = viewport.getOffsetToReveal(renderObject, 0.0);
    final sectionTopInViewport = revealed.rect.top;
    final sectionBottomInViewport = revealed.rect.bottom;
    final visibleTop = 0.0;
    final visibleBottom = viewportSize.height;
    final visibleHeight = (sectionBottomInViewport.clamp(visibleTop, visibleBottom) -
        sectionTopInViewport.clamp(visibleTop, visibleBottom));
    final visibleRatio = (visibleHeight / size.height).clamp(0.0, 1.0);

    if (visibleRatio >= widget.threshold && !_hasAnimated) {
      _hasAnimated = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
