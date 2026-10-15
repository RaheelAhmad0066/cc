import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

class OnboardingStepHeader extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onBack;

  const OnboardingStepHeader({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: AppColors.cardSelectedBg,
            shape: CircleBorder(
              side: BorderSide(color: AppColors.cardBorder, width: 1.w),
            ),
            child: InkWell(
              onTap: onBack,
              customBorder: const CircleBorder(),
              child: SizedBox(
                width: 40.w,
                height: 40.w,
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 24.r,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$currentStep of $totalSteps',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondaryLight,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(totalSteps, (index) {
                  final isActive = index < currentStep;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 24.w,
                    height: 3.5.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: isActive
                          ? AppColors.progressActive
                          : AppColors.progressInactive,
                    ),
                  );
                }),
              ),
            ],
          ),

          SizedBox(width: 40.w),
        ],
      ),
    );
  }
}
