import 'dart:math' as math;
import 'package:flutter/material.dart';

/// ══════════════════════════════════════════════════
/// ScrollReveal - 스크롤 시 페이드+슬라이드 등장
/// ══════════════════════════════════════════════════
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset offset;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 60),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  ScrollPosition? _pos;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: widget.duration, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pos?.removeListener(_check);
    _pos = Scrollable.maybeOf(context)?.position;
    _pos?.addListener(_check);
  }

  @override
  void dispose() {
    _pos?.removeListener(_check);
    _ctrl.dispose();
    super.dispose();
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.of(context).size.height;
    if (top < screenH * 0.92) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = widget.curve.transform(_ctrl.value);
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(
              widget.offset.dx * (1 - t),
              widget.offset.dy * (1 - t),
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// ══════════════════════════════════════════════════
/// TypewriterText - 글자가 한 글자씩 나타나는 효과
/// ══════════════════════════════════════════════════
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration totalDuration;
  final Duration delay;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.totalDuration = const Duration(milliseconds: 1500),
    this.delay = Duration.zero,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  ScrollPosition? _pos;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: widget.totalDuration, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pos?.removeListener(_check);
    _pos = Scrollable.maybeOf(context)?.position;
    _pos?.addListener(_check);
  }

  @override
  void dispose() {
    _pos?.removeListener(_check);
    _ctrl.dispose();
    super.dispose();
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.of(context).size.height;
    if (top < screenH * 0.92) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final n = widget.text.length;
        final chars = (n * _ctrl.value).ceil().clamp(0, n);
        final visible = widget.text.substring(0, chars);
        final cursor = _ctrl.isAnimating ? '│' : '';
        return Text('$visible$cursor', style: widget.style);
      },
    );
  }
}

/// ══════════════════════════════════════════════════
/// CountUpText - 숫자가 0에서 카운트업
/// ══════════════════════════════════════════════════
class CountUpText extends StatefulWidget {
  final double end;
  final String prefix;
  final String suffix;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;
  final int decimals;

  const CountUpText({
    super.key,
    required this.end,
    this.prefix = '',
    this.suffix = '',
    this.style,
    this.duration = const Duration(milliseconds: 2000),
    this.delay = Duration.zero,
    this.decimals = 0,
  });

  @override
  State<CountUpText> createState() => _CountUpTextState();
}

class _CountUpTextState extends State<CountUpText>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  ScrollPosition? _pos;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: widget.duration, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pos?.removeListener(_check);
    _pos = Scrollable.maybeOf(context)?.position;
    _pos?.addListener(_check);
  }

  @override
  void dispose() {
    _pos?.removeListener(_check);
    _ctrl.dispose();
    super.dispose();
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.of(context).size.height;
    if (top < screenH * 0.92) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = Curves.easeOutCubic.transform(_ctrl.value);
        final current = widget.end * t;
        final formatted = widget.decimals == 0
            ? current.round().toString()
            : current.toStringAsFixed(widget.decimals);
        return Text(
          '${widget.prefix}$formatted${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}

/// ══════════════════════════════════════════════════
/// LineReveal - 수평 라인이 왼쪽에서 오른쪽으로 자라남
/// ══════════════════════════════════════════════════
class LineReveal extends StatefulWidget {
  final Color color;
  final double height;
  final double maxWidth;
  final Duration duration;
  final Duration delay;

  const LineReveal({
    super.key,
    required this.color,
    this.height = 2,
    this.maxWidth = double.infinity,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
  });

  @override
  State<LineReveal> createState() => _LineRevealState();
}

class _LineRevealState extends State<LineReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  ScrollPosition? _pos;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: widget.duration, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pos?.removeListener(_check);
    _pos = Scrollable.maybeOf(context)?.position;
    _pos?.addListener(_check);
  }

  @override
  void dispose() {
    _pos?.removeListener(_check);
    _ctrl.dispose();
    super.dispose();
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.of(context).size.height;
    if (top < screenH * 0.92) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = Curves.easeOutCubic.transform(_ctrl.value);
        return LayoutBuilder(
          builder: (_, constraints) {
            final w = math.min(constraints.maxWidth, widget.maxWidth) * t;
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(height: widget.height, width: w, color: widget.color),
            );
          },
        );
      },
    );
  }
}

/// ══════════════════════════════════════════════════
/// ScaleReveal - 스크롤 시 스케일+페이드 등장
/// ══════════════════════════════════════════════════
class ScaleReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double startScale;
  final Curve curve;

  const ScaleReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.startScale = 0.7,
    this.curve = Curves.easeOutBack,
  });

  @override
  State<ScaleReveal> createState() => _ScaleRevealState();
}

class _ScaleRevealState extends State<ScaleReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  ScrollPosition? _pos;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: widget.duration, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pos?.removeListener(_check);
    _pos = Scrollable.maybeOf(context)?.position;
    _pos?.addListener(_check);
  }

  @override
  void dispose() {
    _pos?.removeListener(_check);
    _ctrl.dispose();
    super.dispose();
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.of(context).size.height;
    if (top < screenH * 0.92) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = widget.curve.transform(_ctrl.value.clamp(0.0, 1.0));
        final scale = widget.startScale + (1.0 - widget.startScale) * t;
        return Opacity(
          opacity: _ctrl.value.clamp(0.0, 1.0),
          child: Transform.scale(scale: scale, child: widget.child),
        );
      },
    );
  }
}
