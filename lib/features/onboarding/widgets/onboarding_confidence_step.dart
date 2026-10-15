import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/app_animations.dart';
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
      imageAsset: 'assets/images/ChatGPT Image Oct 10, 2026, 02_16_09 PM-2 1.png',
    ),
    MakeupConfidenceLevel(
      id: 'comfortable',
      title: 'Comfortable',
      subtitle: 'I know my routine and want to improve.',
      icon: Icons.face_4_outlined,
      imageAsset:
          'assets/images/ChatGPT Image Oct 10, 2026, 02_16_08 PM-1 1 copy.png',
    ),
    MakeupConfidenceLevel(
      id: 'advanced',
      title: 'Advanced',
      subtitle: 'I love experimenting with techniques.',
      icon: Icons.auto_fix_high_outlined,
      imageAsset:
          'assets/images/ChatGPT Image Oct 10, 2026, 02_16_12 PM-3 1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            AppAnimations.fadeInUp(
              key: ValueKey('confidence-heading-${provider.currentStep}'),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w400,
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
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Column(
                children: [
                  for (var index = 0; index < _levels.length; index++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: index == _levels.length - 1 ? 0 : 12.h,
                        ),
                        child: AppAnimations.fadeInUp(
                          key: ValueKey(
                            'confidence-${provider.currentStep}-${_levels[index].id}',
                          ),
                          delay: Duration(milliseconds: 120 + (index * 100)),
                          child: _ConfidenceCard(
                            level: _levels[index],
                            selected:
                                provider.selectedConfidence ==
                                _levels[index].id,
                            onTap: () =>
                                provider.setConfidence(_levels[index].id),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            AppAnimations.fadeInUp(
              key: ValueKey('confidence-button-${provider.currentStep}'),
              delay: const Duration(milliseconds: 420),
              child: AppButton(
                text: 'Continue',
                showArrow: true,
                height: 54.h,
                onPressed: () => context.go(AppRoutes.home),
              ),
            ),
            SizedBox(height: 16.h),
          ],
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
    return Semantics(
      button: true,
      selected: selected,
      label: '${level.title}, ${level.subtitle}',
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.all(10.r),
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
                color: AppColors.espresso.withValues(
                  alpha: selected ? 0.08 : 0.035,
                ),
                blurRadius: selected ? 12.r : 7.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: 112.w,
                  height: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                      Image.asset(
                        level.imageAsset,
                        fit: BoxFit.cover,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) return child;
                              return AnimatedOpacity(
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeOut,
                                child: child,
                              );
                            },
                        errorBuilder: (context, error, stackTrace) =>
                            const ColoredBox(color: AppColors.cardSelectedBg),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      level.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      level.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.accentRose : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? AppColors.accentRose
                        : AppColors.cardBorder,
                    width: 1.5.w,
                  ),
                ),
                child: selected
                    ? Icon(Icons.check, size: 15.r, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
