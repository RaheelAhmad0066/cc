import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class OnboardingAssetBackground extends StatelessWidget {
  final String assetPath;

  const OnboardingAssetBackground({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.backgroundLight),
        Image.asset(
          assetPath,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOut,
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) =>
              const ColoredBox(color: AppColors.backgroundLight),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.2, 0.42, 0.72, 1],
              colors: [
                AppColors.backgroundLight.withValues(alpha: 0.96),
                AppColors.backgroundLight.withValues(alpha: 0.82),
                AppColors.backgroundLight.withValues(alpha: 0.18),
                AppColors.backgroundLight.withValues(alpha: 0.82),
                AppColors.backgroundLight,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
