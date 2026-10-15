import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/onboarding_provider.dart';

class OnboardingInspirationStep extends StatelessWidget {
  final OnboardingProvider provider;
  final VoidCallback onComplete;

  const OnboardingInspirationStep({
    super.key,
    required this.provider,
    required this.onComplete,
  });

  static const _occasions = [
    (id: 'everyday', title: 'Everyday', icon: Icons.wb_sunny_outlined),
    (id: 'work', title: 'Work', icon: Icons.work_outline),
    (id: 'date_night', title: 'Date night', icon: Icons.favorite_border),
    (id: 'events', title: 'Events', icon: Icons.celebration_outlined),
    (id: 'weddings', title: 'Weddings', icon: Icons.diamond_outlined),
    (id: 'night_out', title: 'Night out', icon: Icons.nightlife_outlined),
    (id: 'content', title: 'Content / photos', icon: Icons.camera_alt_outlined),
    (
      id: 'experimenting',
      title: 'Just experimenting',
      icon: Icons.auto_awesome,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/Luxury Makeup Still Life with Rose-Gold Accents 1.png',
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.48, 0.75, 1],
              colors: [
                AppColors.backgroundLight,
                AppColors.backgroundLight.withValues(alpha: 0.98),
                AppColors.backgroundLight.withValues(alpha: 0.08),
                AppColors.backgroundLight.withValues(alpha: 0.02),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
          child: Column(
            children: [
              _heading(),
              SizedBox(height: 14.h),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _occasions.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    mainAxisExtent: 43.h,
                  ),
                  itemBuilder: (context, index) {
                    final occasion = _occasions[index];
                    final selected = provider.selectedOccasions.contains(
                      occasion.id,
                    );
                    return _OccasionTile(
                      title: occasion.title,
                      icon: occasion.icon,
                      selected: selected,
                      onTap: () => provider.toggleOccasion(occasion.id),
                    );
                  },
                ),
              ),
              AppButton(
                text: 'Continue',
                showArrow: true,
                height: 52.h,
                onPressed: onComplete,
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
              fontSize: 30.sp,
              height: 1.1,
              color: AppColors.textPrimaryLight,
            ),
            children: [
              const TextSpan(text: 'When do you usually\nwant '),
              TextSpan(
                text: 'inspiration?',
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
          'Pick all the occasions that apply.',
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

class _OccasionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _OccasionTile({
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
                : const Color(0xFFF8F3EF).withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: selected
                  ? AppColors.cardBorderSelected
                  : Colors.transparent,
              width: 1.1.w,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20.r, color: AppColors.textPrimaryLight),
              SizedBox(width: 7.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5.sp,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              _SelectionMark(selected: selected, size: 17.r),
            ],
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
        color: selected ? AppColors.accentRose : Colors.transparent,
        border: Border.all(
          color: selected ? AppColors.accentRose : const Color(0xFFC7BDB7),
          width: 1.1.w,
        ),
      ),
      child: selected
          ? Icon(Icons.check, size: size * 0.68, color: Colors.white)
          : null,
    );
  }
}
