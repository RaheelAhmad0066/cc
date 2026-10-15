import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Elegant brand emblem
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.35),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.auto_awesome,
              size: 42,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // App Brand Name - Driven directly by AppTheme displayLarge
        Text(
          AppConstants.appName,
          style: theme.textTheme.displayLarge?.copyWith(
            letterSpacing: 4.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Tagline - Driven directly by AppTheme bodyMedium
        Text(
          AppConstants.appTagline.toUpperCase(),
          style: theme.textTheme.bodyMedium?.copyWith(
            letterSpacing: 2.5,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.progressActive : AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
