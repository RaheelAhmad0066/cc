import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_confidence_step.dart';
import '../widgets/onboarding_interests_step.dart';
import '../widgets/onboarding_inspiration_step.dart';
import '../widgets/onboarding_intro_step.dart';
import '../widgets/onboarding_photo_guide_step.dart';
import '../widgets/onboarding_product_preferences_step.dart';
import '../widgets/onboarding_style_step.dart';
import '../widgets/onboarding_step_header.dart';
import '../widgets/onboarding_welcome_step.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pageCount = 8;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: Consumer<OnboardingProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              top: provider.currentStep > 0,
              bottom: true,
              child: Column(
                children: [
                  if (provider.currentStep > 0)
                    OnboardingStepHeader(
                      currentStep: provider.currentStep,
                  totalSteps: 7,
                      onBack: () =>
                          provider.previousStep(_pageController),
                    ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _pageCount,
                      itemBuilder: (context, index) {
                        return switch (index) {
                          0 => OnboardingWelcomeStep(
                            provider: provider,
                            pageController: _pageController,
                          ),
                          1 => OnboardingIntroStep(
                            provider: provider,
                            pageController: _pageController,
                          ),
                          2 => OnboardingInterestsStep(
                            provider: provider,
                            pageController: _pageController,
                          ),
                          3 => OnboardingConfidenceStep(
                            provider: provider,
                            pageController: _pageController,
                          ),
                          4 => OnboardingStyleStep(
                            provider: provider,
                            pageController: _pageController,
                          ),
                          5 => OnboardingInspirationStep(
                            provider: provider,
                            pageController: _pageController,
                          ),
                          6 => OnboardingProductPreferencesStep(
                            provider: provider,
                            pageController: _pageController,
                          ),
                          7 => OnboardingPhotoGuideStep(
                            onComplete: () => context.go(AppRoutes.home),
                          ),
                          _ => throw RangeError.index(index, _pageCount),
                        };
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
