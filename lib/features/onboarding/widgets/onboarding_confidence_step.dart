import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/app_animation.dart';
import '../../../core/widgets/app_button.dart';
import '../models/onboarding_models.dart';
import '../providers/onboarding_provider.dart';

class OnboardingConfidenceStep extends StatelessWidget {
  final OnboardingProvider provider;
  final PageController pageController;

  const OnboardingConfidenceStep({
    super.key,
    required this.provider,
    required this.pageController,
  });

  static const _levels = [
    MakeupConfidenceLevel(
      id: 'beginner',
      title: 'Beginner',
      subtitle: "I'm still learning the basics.",
      icon: Icons.face_3_outlined,
    ),
    MakeupConfidenceLevel(
      id: 'comfortable',
      title: 'Comfortable',
      subtitle: 'I know my routine and want to improve.',
      icon: Icons.face_4_outlined,
    ),
    MakeupConfidenceLevel(
      id: 'advanced',
      title: 'Advanced',
      subtitle: 'I love experimenting with techniques.',
      icon: Icons.auto_fix_high_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppAnimation(
      isActive: provider.currentStep == 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                  height: 1.2,
                ),
                children: [
                  const TextSpan(text: 'How confident\nare you with\n'),
                  TextSpan(
                    text: 'makeup?',
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.accentRose,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            ..._levels.map(
              (level) => Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: _ConfidenceCard(
                  level: level,
                  selected: provider.selectedConfidence == level.id,
                  onTap: () => provider.setConfidence(level.id),
                ),
              ),
            ),
            const Spacer(),
            AppButton(
              text: 'Continue',
              showArrow: true,
              height: 54.h,
              onPressed: () => context.go(AppRoutes.home),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _ConfidenceCard extends StatelessWidget {
  final MakeupConfidenceLevel level;
  final bool selected;
  final VoidCallback onTap;

  const _ConfidenceCard({
    required this.level,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: selected ? AppColors.cardSelectedBg : Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected
                ? AppColors.cardBorderSelected
                : AppColors.cardBorder,
            width: selected ? 1.5.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? AppColors.accentRose.withValues(alpha: 0.12)
                    : AppColors.backgroundLight,
              ),
              child: Icon(
                level.icon,
                size: 34.r,
                color: selected
                    ? AppColors.accentRose
                    : AppColors.textSecondaryLight,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level.title,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    level.subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5.sp,
                      color: AppColors.textSecondaryLight,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.accentRose : Colors.transparent,
                border: Border.all(
                  color: selected ? AppColors.accentRose : AppColors.cardBorder,
                  width: 1.5.w,
                ),
              ),
              child: selected
                  ? Icon(Icons.check, size: 14.r, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
