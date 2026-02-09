import 'package:flutter/material.dart';

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
    
    final viewport = RenderAbstractViewport.of(renderObject);
    if (viewport == null) return;
    
    final revealOffset = viewport.getRevealOffset(renderObject);
    final viewportSize = viewport.size;
    final renderBox = renderObject as RenderBox;
    final size = renderBox.size;
    
    final visibleTop = -revealOffset.dy;
    final visibleBottom = visibleTop + viewportSize.height;
    final sectionTop = renderBox.localToGlobal(Offset.zero).dy;
    final sectionBottom = sectionTop + size.height;
    
    final visibleRatio = (visibleBottom - sectionTop) / (size.height + viewportSize.height);
    
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
