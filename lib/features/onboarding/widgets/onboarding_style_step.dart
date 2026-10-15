import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/onboarding_provider.dart';

class OnboardingStyleStep extends StatelessWidget {
  final OnboardingProvider provider;
  final PageController pageController;

  const OnboardingStyleStep({
    super.key,
    required this.provider,
    required this.pageController,
  });

  static const _styles = [
    (
      id: 'natural',
      title: 'Natural',
      image: 'assets/images/ChatGPT Image Oct 10, 2026, 02_16_24 PM-1 1 copy.png',
    ),
    (
      id: 'soft_glam',
      title: 'Soft Glam',
      image: 'assets/images/ChatGPT Image Oct 10, 2026, 02_16_26 PM-2 1 copy.png',
    ),
    (
      id: 'clean',
      title: 'Clean',
      image: 'assets/images/ChatGPT Image Oct 10, 2026, 02_16_29 PM-3 1.png',
    ),
    (
      id: 'romantic',
      title: 'Romantic',
      image: 'assets/images/ChatGPT Image Oct 10, 2026, 02_16_32 PM-4 1 copy.png',
    ),
    (
      id: 'bold',
      title: 'Bold',
      image: 'assets/images/ChatGPT Image Oct 10, 2026, 02_16_34 PM-5 1 copy.png',
    ),
    (
      id: 'full_glam',
      title: 'Full Glam',
      image: 'assets/images/ChatGPT Image Oct 10, 2026, 02_16_39 PM-6 1 copy.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
      child: Column(
        children: [
          _heading(),
          SizedBox(height: 14.h),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _styles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 8.h,
                childAspectRatio: 1.16,
              ),
              itemBuilder: (context, index) {
                final style = _styles[index];
                final selected = provider.selectedStyles.contains(style.id);
                return _StyleCard(
                  title: style.title,
                  imageAsset: style.image,
                  selected: selected,
                  onTap: () => provider.toggleStyle(style.id),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          AppButton(
            text: 'Continue',
            showArrow: true,
            height: 52.h,
            onPressed: () => provider.nextStep(pageController),
          ),
        ],
      ),
    );
  }

  Widget _heading() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.playfairDisplay(
              fontSize: 31.sp,
              height: 1.12,
              color: AppColors.textPrimaryLight,
            ),
            children: [
              const TextSpan(text: 'What feels most like '),
              TextSpan(
                text: 'you?',
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
          "Pick all the styles you're drawn to.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 12.5.sp,
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}

class _StyleCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final bool selected;
  final VoidCallback onTap;

  const _StyleCard({
    required this.title,
    required this.imageAsset,
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
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.r),
            border: Border.all(
              color: selected
                  ? AppColors.cardBorderSelected
                  : Colors.transparent,
              width: 1.4.w,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(imageAsset, fit: BoxFit.cover),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xAA1E1510)],
                      stops: [0.45, 1],
                    ),
                  ),
                ),
                Positioned(
                  left: 10.w,
                  bottom: 7.h,
                  child: Text(
                    title,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
                Positioned(
                  top: 7.h,
                  right: 7.w,
                  child: _SelectionMark(selected: selected, size: 23.r),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionMark extends StatelessWidget {
  final bool selected;
  final double size;

  const _SelectionMark({required this.selected, required this.size});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.accentRose : Colors.black12,
        border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
      ),
      child: selected
          ? Icon(Icons.check, size: size * 0.68, color: Colors.white)
          : null,
    );
  }
}
