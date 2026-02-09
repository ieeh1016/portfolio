import 'package:flutter/material.dart';
import '../app_theme.dart';

class SectionIndicator extends StatefulWidget {
  final ScrollController scrollController;
  final List<SectionInfo> sections;
  final Function(String) onSectionTap;

  const SectionIndicator({
    super.key,
    required this.scrollController,
    required this.sections,
    required this.onSectionTap,
  });

  @override
  State<SectionIndicator> createState() => _SectionIndicatorState();
}

class _SectionIndicatorState extends State<SectionIndicator> {
  String? _activeSection;
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateActiveSection);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateActiveSection);
    super.dispose();
  }

  void _updateActiveSection() {
    if (!widget.scrollController.hasClients) return;
    
    final scrollOffset = widget.scrollController.offset;
    final viewportHeight = MediaQuery.of(context).size.height;
    final threshold = viewportHeight * 0.3;
    
    String? newActiveSection;
    for (final section in widget.sections) {
      final key = section.key;
      if (key?.currentContext != null) {
        final renderBox = key!.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final sectionTop = position.dy + scrollOffset;
          final sectionBottom = sectionTop + renderBox.size.height;
          
          if (scrollOffset + threshold >= sectionTop && scrollOffset + threshold <= sectionBottom) {
            newActiveSection = section.id;
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    if (isMobile) return const SizedBox.shrink();
    
    return Positioned(
      right: 24,
      top: 0,
      bottom: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.sections.map((section) {
              final isActive = _activeSection == section.id;
              return GestureDetector(
                onTap: () => widget.onSectionTap(section.id),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: isActive ? 12 : 8,
                  height: isActive ? 12 : 8,
                  decoration: BoxDecoration(
                    gradient: isActive ? AppTheme.primaryGradient : null,
                    color: isActive ? null : AppTheme.textTertiary.withOpacity(0.3),
                    shape: BoxShape.circle,
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class SectionInfo {
  final String id;
  final GlobalKey? key;

  const SectionInfo({required this.id, this.key});
}
