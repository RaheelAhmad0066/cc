import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide AppButton;
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_button.dart';
import '../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              toast('Notifications opened');
            },
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Welcome Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover Your Style',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      8.height,
                      Text(
                        'Explore curated looks, customized palettes, and premium finishes.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                24.height,

                Text(
                  'Quick Actions',
                  style: theme.textTheme.titleLarge,
                ),
                16.height,

                // Custom AppButton Component Demonstration
                AppButton(
                  text: 'Explore Catalog',
                  isLoading: homeProvider.isLoading,
                  icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                  onPressed: () {
                    toast('Exploring beauty styles!');
                    homeProvider.refreshHome();
                  },
                ),
                12.height,

                AppButton(
                  text: 'View Saved Looks',
                  isOutlined: true,
                  onPressed: () {
                    toast('Opening saved collections');
                  },
                ),

                24.height,

                // Info Card demonstrating AppTheme cardTheme
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle_outline,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        16.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Clean Architecture Active',
                                style: theme.textTheme.titleMedium,
                              ),
                              4.height,
                              Text(
                                'Feature-first modular structure with Provider, GoRouter, and nb_utils.',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

