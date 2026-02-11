import 'dart:ui';
import 'package:flutter/material.dart';
import '../app_theme.dart';

class AnimatedNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String) onSectionTap;
  final Map<String, GlobalKey> sectionKeys;
  final bool isMobile;

  const AnimatedNavBar({
    super.key,
    required this.scrollController,
    required this.onSectionTap,
    required this.sectionKeys,
    this.isMobile = false,
  });

  @override
  State<AnimatedNavBar> createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  String? _activeSection;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = widget.scrollController.offset > 100;
    if (shouldShow != _isVisible) {
      setState(() => _isVisible = shouldShow);
      if (_isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    _updateActiveSection();
  }

  void _updateActiveSection() {
    if (!widget.scrollController.hasClients) return;
    
    final scrollOffset = widget.scrollController.offset;
    final viewportHeight = MediaQuery.of(context).size.height;
    final threshold = viewportHeight * 0.3;
    
    String? newActiveSection;
    for (final entry in widget.sectionKeys.entries) {
      final key = entry.value;
      if (key.currentContext != null) {
        final renderBox = key.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final sectionTop = position.dy + scrollOffset;
          final sectionBottom = sectionTop + renderBox.size.height;
          
          if (scrollOffset + threshold >= sectionTop && scrollOffset + threshold <= sectionBottom) {
            newActiveSection = entry.key;
            break;
          }
        }
      }
    }
    
    if (newActiveSection != _activeSection) {
      setState(() => _activeSection = newActiveSection);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible && !widget.isMobile) return const SizedBox.shrink();

    if (widget.isMobile) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.code_rounded,
                color: AppTheme.primary,
                size: 22,
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
        ),
      );
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _NavItem(
                    label: '소개',
                    isActive: _activeSection == 'intro',
                    onTap: () => widget.onSectionTap('intro'),
                  ),
                  const SizedBox(width: 24),
                  _NavItem(
                    label: '경력',
                    isActive: _activeSection == 'career',
                    onTap: () => widget.onSectionTap('career'),
                  ),
                  const SizedBox(width: 24),
                  _NavItem(
                    label: '학력',
                    isActive: _activeSection == 'education',
                    onTap: () => widget.onSectionTap('education'),
                  ),
                  const SizedBox(width: 24),
                  _NavItem(
                    label: '연락처',
                    isActive: _activeSection == 'contact',
                    onTap: () => widget.onSectionTap('contact'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final shouldHighlight = widget.isActive || _isHovered;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: shouldHighlight ? AppTheme.primaryGradient : null,
            borderRadius: BorderRadius.circular(20),
            border: widget.isActive && !shouldHighlight
                ? Border.all(color: AppTheme.primary, width: 2)
                : null,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: shouldHighlight
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
