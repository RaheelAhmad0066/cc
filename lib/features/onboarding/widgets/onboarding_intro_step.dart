import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_animations.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/onboarding_provider.dart';
import 'onboarding_asset_background.dart';

class OnboardingIntroStep extends StatelessWidget {
  final OnboardingProvider provider;
  final PageController pageController;

  const OnboardingIntroStep({
    super.key,
    required this.provider,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const OnboardingAssetBackground(
          assetPath: 'assets/images/Luxury Makeup Still Life with Rose-Gold Accents 1.png',
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                AppAnimations.fadeInUp(
                  key: ValueKey('intro-heading-${provider.currentStep}'),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimaryLight,
                        height: 1.2,
                      ),
                      children: [
                        const TextSpan(text: "Let's make\nMuse AI "),
                        TextSpan(
                          text: 'yours.',
                          style: GoogleFonts.playfairDisplay(
                            color: AppColors.accentRose,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                AppAnimations.fadeInUp(
                  key: ValueKey('intro-description-${provider.currentStep}'),
                  delay: const Duration(milliseconds: 120),
                  child: Text(
                    "A few quick choices help us recommend looks you'll actually want to wear.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14.5.sp,
                      color: AppColors.textSecondaryLight,
                      height: 1.45,
                    ),
                  ),
                ),
                const Spacer(),
                const Spacer(flex: 2),
                AppAnimations.fadeInUp(
                  key: ValueKey('intro-duration-${provider.currentStep}'),
                  delay: const Duration(milliseconds: 240),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 15.r,
                        color: AppColors.textSecondaryLight,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'About 1 minute',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                AppAnimations.fadeInUp(
                  key: ValueKey('intro-button-${provider.currentStep}'),
                  delay: const Duration(milliseconds: 320),
                  child: AppButton(
                    text: 'Continue',
                    showArrow: true,
                    height: 54.h,
                    onPressed: () => provider.nextStep(pageController),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
        ),
      ],
    );
  }
}
