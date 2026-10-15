import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/app_animations.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/onboarding_provider.dart';

class OnboardingWelcomeStep extends StatelessWidget {
  final OnboardingProvider provider;
  final PageController pageController;

  const OnboardingWelcomeStep({
    super.key,
    required this.provider,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return AppAnimations.fadeInUp(
      key: ValueKey(provider.currentStep),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.66.sh,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/Warm Windowlight Beauty Portrait 1.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFF0E5DF),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 80.r,
                      color: AppColors.accentRose,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 0.45, 0.85, 1],
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        AppColors.backgroundLight.withValues(alpha: 0.8),
                        AppColors.backgroundLight,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24.w,
            right: 24.w,
            bottom: 50.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textPrimaryLight,
                      height: 1.15,
                    ),
                    children: [
                      const TextSpan(text: 'Makeup,\nmade for '),
                      TextSpan(
                        text: 'you.',
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.accentRose,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  'Discover looks designed around your features, preview them on yourself, and learn exactly how to recreate them.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(fontSize: 14.sp, height: 1.5),
                ),
                SizedBox(height: 28.h),
                AppButton(
                  text: 'Get started',
                  showArrow: true,
                  height: 54.h,
                  onPressed: () => provider.nextStep(pageController),
                ),
                SizedBox(height: 14.h),
                TextButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: Text(
                    'I already have an account',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentRose,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 13.r,
                      color: AppColors.textMuted,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Your photos stay under your control.',
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
