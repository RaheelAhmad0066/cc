import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_animations.dart';
import '../../../core/widgets/app_button.dart';
import '../models/onboarding_models.dart';
import '../providers/onboarding_provider.dart';

class OnboardingInterestsStep extends StatelessWidget {
  final OnboardingProvider provider;
  final PageController pageController;

  const OnboardingInterestsStep({
    super.key,
    required this.provider,
    required this.pageController,
  });

  static const _interests = [
    HelpInterest(
      id: 'suits_me',
      title: 'Find makeup that suits me',
      icon: Iconsax.user_square,
      imageAsset: 'assets/images/01_try_museai_look 1.png',
    ),
    HelpInterest(
      id: 'apply',
      title: 'Learn how to apply makeup',
      icon: Iconsax.brush,
      imageAsset:
          'assets/images/ChatGPT Image Oct 10, 2026, 02_15_03 PM-2 1 copy.png',
    ),
    HelpInterest(
      id: 'try_new',
      title: 'Try new looks',
      icon: Iconsax.magicpen,
      imageAsset:
          'assets/images/ChatGPT Image Oct 10, 2026, 02_16_26 PM-2 1.png',
    ),
    HelpInterest(
      id: 'shades',
      title: 'Find better shades',
      icon: Iconsax.colorfilter,
      imageAsset:
          'assets/images/ChatGPT Image Oct 10, 2026, 02_15_09 PM-4 1.png',
    ),
    HelpInterest(
      id: 'own_products',
      title: 'Use products I already own',
      icon: Iconsax.bag_2,
      imageAsset:
          'assets/images/ChatGPT Image Oct 10, 2026, 02_15_12 PM-5 1 copy.png',
    ),
    HelpInterest(
      id: 'recreate',
      title: 'Recreate looks I see online',
      icon: Iconsax.gallery,
      imageAsset:
          'assets/images/ChatGPT Image Oct 10, 2026, 02_15_15 PM-6 1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppAnimations.fadeInUp(
      key: ValueKey(provider.currentStep),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.playfairDisplay(
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimaryLight,
                  height: 1.2,
                ),
                children: [
                  const TextSpan(text: 'What would you\nlove '),
                  TextSpan(
                    text: 'help with?',
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.accentRose,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose as many as you like.',
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: AppColors.textSecondaryLight,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: GridView.builder(
                itemCount: _interests.length,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.17,
                ),
                itemBuilder: (context, index) {
                  final interest = _interests[index];
                  return _InterestCard(
                    interest: interest,
                    selected: provider.selectedInterests.contains(interest.id),
                    onTap: () => provider.toggleInterest(interest.id),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            AppButton(
              text: 'Continue',
              showArrow: true,
              height: 54.h,
              onPressed: () => provider.nextStep(pageController),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _InterestCard extends StatelessWidget {
  final HelpInterest interest;
  final bool selected;
  final VoidCallback onTap;

  const _InterestCard({
    required this.interest,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: selected ? AppColors.cardSelectedBg : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected
                ? AppColors.cardBorderSelected
                : AppColors.cardBorder,
            width: selected ? 1.5.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.espresso.withValues(
                alpha: selected ? 0.09 : 0.035,
              ),
              blurRadius: selected ? 14.r : 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const ColoredBox(color: AppColors.cardSelectedBg),
                    Image.asset(
                      interest.imageAsset ??
                          'assets/images/Freckled Beauty Scan Portrait 1.png',
                      fit: BoxFit.cover,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) return child;
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(milliseconds: 300),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                children: [
                  Icon(
                    interest.icon,
                    size: 22.r,
                    color: AppColors.textSecondaryLight,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      interest.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimaryLight,
                        height: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected
                          ? AppColors.accentRose
                          : Colors.transparent,
                      border: Border.all(
                        color: selected
                            ? AppColors.accentRose
                            : AppColors.cardBorder,
                        width: 1.5.w,
                      ),
                    ),
                    child: selected
                        ? Icon(
                            Iconsax.tick_circle,
                            size: 14.r,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
