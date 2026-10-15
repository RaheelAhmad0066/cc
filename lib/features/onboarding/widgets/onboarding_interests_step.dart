import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_animation.dart';
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
      icon: Icons.face_retouching_natural_rounded,
      imageAsset: 'assets/images/01_try_museai_look 1.png',
    ),
    HelpInterest(
      id: 'apply',
      title: 'Learn how to apply makeup',
      icon: Icons.brush_outlined,
      imageAsset: 'assets/01_try_museai_look 1.png',
    ),
    HelpInterest(
      id: 'try_new',
      title: 'Try new looks',
      icon: Icons.auto_awesome_outlined,
      imageAsset: 'assets/images/warm_soft_glam 1.png',
    ),
    HelpInterest(
      id: 'shades',
      title: 'Find better shades',
      icon: Icons.colorize_outlined,
      imageAsset: 'assets/images/Freckled Beauty Scan Portrait 1.png',
    ),
    HelpInterest(
      id: 'own_products',
      title: 'Use products I already own',
      icon: Icons.shopping_bag_outlined,
      imageAsset:
          'assets/images/Luxury Makeup Still Life with Rose-Gold Accents 1.png',
    ),
    HelpInterest(
      id: 'recreate',
      title: 'Recreate looks I see online',
      icon: Icons.image_outlined,
      imageAsset: 'assets/images/Warm Windowlight Beauty Portrait 1.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppAnimation(
      isActive: provider.currentStep == 2,
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
                  childAspectRatio: 1.02,
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
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          color: selected ? AppColors.cardSelectedBg : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: selected
                ? AppColors.cardBorderSelected
                : AppColors.cardBorder,
            width: selected ? 1.5.w : 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                child: Image.asset(
                  interest.imageAsset ??
                      'assets/images/Freckled Beauty Scan Portrait 1.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => ColoredBox(
                    color: AppColors.cardSelectedBg,
                    child: Icon(interest.icon, color: AppColors.accentRose),
                  ),
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
                        ? Icon(Icons.check, size: 14.r, color: Colors.white)
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
