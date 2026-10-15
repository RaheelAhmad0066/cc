import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingStepHeader extends StatelessWidget {
  final int currentStep; // 1-based: 1, 2, 3
  final int totalSteps;  // 5
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Circular Back Button
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppColors.cardBorder, width: 1),
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                size: 22,
                color: AppColors.textPrimaryLight,
              ),
            ),
          ),

          // Center: Step text & Segmented Progress Bar
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$currentStep of $totalSteps',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(totalSteps, (index) {
                  final isActive = index < currentStep;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 24,
                    height: 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isActive
                          ? AppColors.progressActive
                          : AppColors.progressInactive,
                    ),
                  );
                }),
              ),
            ],
          ),

          // Placeholder to balance row
          const SizedBox(width: 38),
        ],
      ),
    );
  }
}

