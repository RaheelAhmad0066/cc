import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimations extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset slideOffset;
  final double beginOpacity;
  final double endOpacity;
  final double beginScale;
  final double endScale;
  final Curve curve;

  const AppAnimations({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = const Offset(0, 0.1),
    this.beginOpacity = 0,
    this.endOpacity = 1,
    this.beginScale = 1,
    this.endScale = 1,
    this.curve = Curves.easeOutCubic,
  });

  factory AppAnimations.fadeInUp({
    Key? key,
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 600),
    double slideDistance = 30,
  }) {
    return AppAnimations(
      key: key,
      delay: delay,
      duration: duration,
      slideOffset: Offset(0, slideDistance / 100),
      child: child,
    );
  }

  factory AppAnimations.fadeInDown({
    Key? key,
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 600),
    double slideDistance = -30,
  }) {
    return AppAnimations(
      key: key,
      delay: delay,
      duration: duration,
      slideOffset: Offset(0, slideDistance / 100),
      child: child,
    );
  }

  factory AppAnimations.scaleIn({
    Key? key,
    required Widget child,
    Duration delay = Duration.zero,
    Duration duration = const Duration(milliseconds: 600),
    double beginScale = 0.8,
  }) {
    return AppAnimations(
      key: key,
      delay: delay,
      duration: duration,
      beginScale: beginScale,
      slideOffset: Offset.zero,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var animation = child
        .animate(delay: delay)
        .fade(
          duration: duration,
          begin: beginOpacity,
          end: endOpacity,
          curve: curve,
        );

    if (slideOffset != Offset.zero) {
      animation = animation.slide(
        begin: slideOffset,
        end: Offset.zero,
        duration: duration,
        curve: curve,
      );
    }

    if (beginScale != endScale) {
      animation = animation.scale(
        begin: Offset(beginScale, beginScale),
        end: Offset(endScale, endScale),
        duration: duration,
        curve: curve,
      );
    }

    return animation;
  }
}

class StaggeredListAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration interval;
  final Duration initialDelay;

  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.interval = const Duration(milliseconds: 100),
    this.initialDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < children.length; index++)
          AppAnimations.fadeInUp(
            key: ValueKey(index),
            delay: initialDelay + (interval * index),
            child: children[index],
          ),
      ],
    );
  }
}
