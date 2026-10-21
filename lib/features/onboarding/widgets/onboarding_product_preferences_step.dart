import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_animations.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/onboarding_provider.dart';

class OnboardingProductPreferencesStep extends StatelessWidget {
  final OnboardingProvider provider;
  final PageController pageController;

  const OnboardingProductPreferencesStep({
    super.key,
    required this.provider,
    required this.pageController,
  });

  static const _preferences = [
    (id: 'budget', title: 'Budget friendly', icon: Icons.savings_outlined),
    (id: 'luxury', title: 'Luxury', icon: Icons.diamond_outlined),
    (id: 'cruelty_free', title: 'Cruelty-free', icon: Icons.pets_outlined),
    (id: 'vegan', title: 'Vegan', icon: Icons.eco_outlined),
    (id: 'fragrance_free', title: 'Fragrance-free', icon: Icons.spa_outlined),
    (id: 'long_wearing', title: 'Long-wearing', icon: Icons.schedule),
    (id: 'easy_apply', title: 'Easy to apply', icon: Icons.brush_outlined),
    (id: 'no_preference', title: 'No preference', icon: Icons.tune),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/Sunlit Rose-Gold Makeup Still Life 1.png',
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
          frameBuilder: _fadeInImage,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.48, 0.72, 1],
              colors: [
                AppColors.backgroundLight,
                AppColors.backgroundLight,
                Color(0xCCFAF7F2),
                Color(0x08FAF7F2),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 10.h),
          child: Column(
            children: [
              AppAnimations.fadeInUp(
                key: ValueKey('product-heading-${provider.currentStep}'),
                slideDistance: 20,
                duration: const Duration(milliseconds: 450),
                child: _heading(),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _preferences.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    mainAxisExtent: 42.h,
                  ),
                  itemBuilder: (context, index) {
                    final preference = _preferences[index];
                    final selected = provider.selectedProductPreferences
                        .contains(preference.id);
                    return AppAnimations.fadeInUp(
                      key: ValueKey(
                        'product-${provider.currentStep}-${preference.id}',
                      ),
                      delay: Duration(milliseconds: 60 + index * 45),
                      duration: const Duration(milliseconds: 400),
                      slideDistance: 14,
                      child: _PreferenceTile(
                        title: preference.title,
                        icon: preference.icon,
                        selected: selected,
                        onTap: () =>
                            provider.toggleProductPreference(preference.id),
                      ),
                    );
                  },
                ),
              ),
              AppAnimations.fadeInUp(
                key: ValueKey('product-button-${provider.currentStep}'),
                delay: const Duration(milliseconds: 360),
                duration: const Duration(milliseconds: 420),
                slideDistance: 14,
                child: AppButton(
                  text: 'Continue',
                  showArrow: true,
                  height: 48.h,
                  onPressed: () => provider.nextStep(pageController),
                ),
              ),
              TextButton(
                onPressed: () => provider.nextStep(pageController),
                child: Text(
                  'Skip for now',
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _heading() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.playfairDisplay(
              fontSize: 28.sp,
              height: 1.12,
              color: AppColors.textPrimaryLight,
            ),
            children: [
              const TextSpan(text: 'What matters when\nchoosing '),
              TextSpan(
                text: 'products?',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.accentRose,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          'Pick all the options that are important to you.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _fadeInImage(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded) return child;
    return AnimatedOpacity(
      opacity: frame == null ? 0 : 1,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOut,
      child: child,
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PreferenceTile({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: title,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accentRoseSoft
                : const Color(0xFFF8F3EF).withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(
              color: selected
                  ? AppColors.cardBorderSelected
                  : Colors.transparent,
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 17.r, color: AppColors.textPrimaryLight),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 9.5.sp,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                size: 17.r,
                color: selected
                    ? AppColors.accentRose
                    : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
