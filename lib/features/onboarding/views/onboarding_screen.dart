import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/app_button.dart';
import '../models/onboarding_models.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_step_header.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Screen 1: Welcome / Get Started Hero
                  _buildScreenOne(context, provider),

                  // Screen 2: Intro / "Let's make Muse AI yours"
                  _buildScreenTwo(context, provider),

                  // Screen 3: "What would you love help with?" (2x3 Grid)
                  _buildScreenThree(context, provider),

                  // Screen 4: "How confident are you with makeup?"
                  _buildScreenFour(context, provider),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================
  // SCREEN 1: Hero Welcome Screen
  // ==========================================
  Widget _buildScreenOne(BuildContext context, OnboardingProvider provider) {
    return Stack(
      children: [
        // Top model photo with smooth bottom gradient fade
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 0.66.sh,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/Warm Windowlight Beauty Portrait 1.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFF0E5DF),
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.accentRose,
                  ),
                ),
              ),
              // Fade overlay into background color
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.45, 0.85, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      AppColors.backgroundLight.withOpacity(0.8),
                      AppColors.backgroundLight,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom content
        Positioned(
          left: 24.w,
          right: 24.w,
          bottom: 50.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Editorial Title: "Makeup,\nmade for you."
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.textPrimaryLight,
                    height: 1.15,
                  ),
                  children: [
                    const TextSpan(text: 'Makeup,\nmade for '),
                    TextSpan(
                      text: 'you.',
                      style: GoogleFonts.playfairDisplay(
                        color: AppColors.accentRose,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // Subtitle
              Text(
                'Discover looks designed around your features, preview them on yourself, and learn exactly how to recreate them.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontSize: 14.sp, height: 1.5),
              ),
              SizedBox(height: 28.h),

              // Get Started CTA
              AppButton(
                text: 'Get started',
                showArrow: true,
                height: 54.h,
                onPressed: () => provider.nextStep(_pageController),
              ),
              SizedBox(height: 14.h),

              // Text Button: "I already have an account"
              TextButton(
                onPressed: () {
                  context.go(AppRoutes.home);
                },
                child: Text(
                  'I already have an account',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentRose,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              // Security & Privacy Disclaimer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(
                    Icons.lock_outline_rounded,
                    size: 13.r,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Your photos stay under your control.',
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SCREEN 2: "Let's make Muse AI yours."
  // ==========================================
  Widget _buildScreenTwo(BuildContext context, OnboardingProvider provider) {
    return Column(
      children: [
        OnboardingStepHeader(
          currentStep: 1,
          totalSteps: 5,
          onBack: () => provider.previousStep(_pageController),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Heading: "Let's make\nMuse AI yours."
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
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
                const SizedBox(height: 12),
                Text(
                  "A few quick choices help us recommend looks you'll actually want to wear.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    color: AppColors.textSecondaryLight,
                    height: 1.45,
                  ),
                ),
                const Spacer(),

                // Center visual: Cosmetic Still Life
                Container(
                  constraints: const BoxConstraints(maxHeight: 310),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      'assets/images/Luxury Makeup Still Life with Rose-Gold Accents 1.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 250,
                        color: AppColors.cardSelectedBg,
                        child: const Center(
                          child: Icon(
                            Icons.auto_awesome,
                            size: 60,
                            color: AppColors.accentRose,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),

                // Badge: Clock icon + "About 1 minute"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: AppColors.textSecondaryLight,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'About 1 minute',
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Continue CTA Button
                AppButton(
                  text: 'Continue',
                  showArrow: true,
                  onPressed: () => provider.nextStep(_pageController),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SCREEN 3: "What would you love help with?" (2x3 Grid)
  // ==========================================
  Widget _buildScreenThree(BuildContext context, OnboardingProvider provider) {
    final items = [
      const HelpInterest(
        id: 'suits_me',
        title: 'Find makeup that suits me',
        icon: Icons.face_retouching_natural_rounded,
        imageAsset: 'assets/images/Freckled Beauty Scan Portrait 1.png',
      ),
      const HelpInterest(
        id: 'apply',
        title: 'Learn how to apply makeup',
        icon: Icons.brush_outlined,
        imageAsset: 'assets/images/soft_glam 1.png',
      ),
      const HelpInterest(
        id: 'try_new',
        title: 'Try new looks',
        icon: Icons.auto_awesome_outlined,
        imageAsset: 'assets/images/warm_soft_glam 1.png',
      ),
      const HelpInterest(
        id: 'shades',
        title: 'Find better shades',
        icon: Icons.colorize_outlined,
        imageAsset: 'assets/images/Freckled Beauty Scan Portrait 1.png',
      ),
      const HelpInterest(
        id: 'own_products',
        title: 'Use products I already own',
        icon: Icons.shopping_bag_outlined,
        imageAsset: 'assets/images/Luxury Makeup Still Life with Rose-Gold Accents 1.png',
      ),
      const HelpInterest(
        id: 'recreate',
        title: 'Recreate looks I see online',
        icon: Icons.image_outlined,
        imageAsset: 'assets/images/Warm Windowlight Beauty Portrait 1.png',
      ),
    ];

    return Column(
      children: [
        OnboardingStepHeader(
          currentStep: 2,
          totalSteps: 5,
          onBack: () => provider.previousStep(_pageController),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Heading: "What would you\nlove help with?"
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
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
                const SizedBox(height: 8),
                Text(
                  'Choose as many as you like.',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 16),

                // 2x3 Grid
                Expanded(
                  child: GridView.builder(
                    itemCount: items.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.88,
                        ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = provider.selectedInterests.contains(
                        item.id,
                      );

                      return GestureDetector(
                        onTap: () => provider.toggleInterest(item.id),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.cardSelectedBg
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.cardBorderSelected
                                  : AppColors.cardBorder,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Photo container
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(14),
                                  ),
                                  child: Image.asset(
                                    item.imageAsset ?? 'assets/images/Freckled Beauty Scan Portrait 1.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: AppColors.cardSelectedBg,
                                      child: Icon(
                                        item.icon,
                                        color: AppColors.accentRose,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Bottom bar: icon + title + indicator
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      item.icon,
                                      size: 15,
                                      color: AppColors.textSecondaryLight,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textPrimaryLight,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),

                                    // Checkmark Indicator
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? AppColors.accentRose
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.accentRose
                                              : AppColors.cardBorder,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              size: 12,
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
                    },
                  ),
                ),

                const SizedBox(height: 12),
                AppButton(
                  text: 'Continue',
                  showArrow: true,
                  onPressed: () => provider.nextStep(_pageController),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SCREEN 4: "How confident are you with makeup?"
  // ==========================================
  Widget _buildScreenFour(BuildContext context, OnboardingProvider provider) {
    final levels = [
      const MakeupConfidenceLevel(
        id: 'beginner',
        title: 'Beginner',
        subtitle: "I'm still learning the basics.",
        icon: Icons.face_3_outlined,
      ),
      const MakeupConfidenceLevel(
        id: 'comfortable',
        title: 'Comfortable',
        subtitle: 'I know my routine and want to improve.',
        icon: Icons.face_4_outlined,
      ),
      const MakeupConfidenceLevel(
        id: 'advanced',
        title: 'Advanced',
        subtitle: 'I love experimenting with techniques.',
        icon: Icons.auto_fix_high_outlined,
      ),
    ];

    return Column(
      children: [
        OnboardingStepHeader(
          currentStep: 3,
          totalSteps: 5,
          onBack: () => provider.previousStep(_pageController),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Heading: "How confident\nare you with\nmakeup?"
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
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
                const SizedBox(height: 32),

                // 3 Vertical Selection Cards
                ...levels.map((level) {
                  final isSelected = provider.selectedConfidence == level.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: GestureDetector(
                      onTap: () => provider.setConfidence(level.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.cardSelectedBg
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.cardBorderSelected
                                : AppColors.cardBorder,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Illustration placeholder avatar
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.accentRose.withOpacity(0.12)
                                    : AppColors.backgroundLight,
                              ),
                              child: Icon(
                                level.icon,
                                size: 34,
                                color: isSelected
                                    ? AppColors.accentRose
                                    : AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Title & Subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    level.title,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimaryLight,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    level.subtitle,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      color: AppColors.textSecondaryLight,
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Radio Indicator
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? AppColors.accentRose
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.accentRose
                                      : AppColors.cardBorder,
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                const Spacer(),

                // Continue CTA Button
                AppButton(
                  text: 'Continue',
                  showArrow: true,
                  onPressed: () {
                    context.go(AppRoutes.home);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
