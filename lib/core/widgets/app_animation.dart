import 'package:flutter/material.dart';

class AppAnimation extends StatefulWidget {
  final Widget child;
  final bool isActive;
  final Duration duration;

  const AppAnimation({
    super.key,
    required this.child,
    required this.isActive,
    this.duration = const Duration(milliseconds: 450),
  });

  @override
  State<AppAnimation> createState() => _AppAnimationState();
}

class _AppAnimationState extends State<AppAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.isActive ? 0 : 1,
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AppAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward(from: 0);
    } else if (!widget.isActive && oldWidget.isActive) {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
