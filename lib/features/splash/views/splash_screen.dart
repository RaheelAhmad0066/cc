import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/app_loading_indicator.dart';
import '../providers/splash_provider.dart';
import '../widgets/splash_logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Splash module manages its own SplashProvider instance
    return ChangeNotifierProvider(
      create: (ctx) => SplashProvider()
        ..initializeApp(
          onComplete: () {
            if (ctx.mounted) {
              ctx.go(AppRoutes.onboarding);
            }
          },
        ),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    AppColors.backgroundDark,
                    AppColors.surfaceDark,
                    AppColors.primaryDark.withOpacity(0.3),
                  ]
                : [
                    AppColors.backgroundLight,
                    Colors.white,
                    AppColors.primaryLight.withOpacity(0.12),
                  ],
          ),
        ),
        child: SafeArea(
          child: Consumer<SplashProvider>(
            builder: (context, splashProvider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Custom module component: Splash Logo & Brand typography
                  const SplashLogoWidget(),

                  const Spacer(),

                  // Custom core component: App Loading Indicator
                  const AppLoadingIndicator(size: 32),
                  16.height,

                  // Status message from SplashProvider
                  Text(
                    splashProvider.statusMessage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),

                  20.height,

                  // Progress bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: splashProvider.progress,
                        minHeight: 4,
                        backgroundColor: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),

                  36.height,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

