import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand Colors (Muse AI Luxury Espresso Palette)
  static const Color espresso = Color(0xFF261C16);
  static const Color espressoLight = Color(0xFF3D2D24);
  static const Color primary = espresso;
  static const Color primaryDark = Color(0xFF19120E);
  static const Color primaryLight = Color(0xFF4A392F);

  // Accent Mauve / Rose Colors (Used for italicized accents, active progress, selection)
  static const Color accentRose = Color(0xFFA85D5B);
  static const Color accentRoseLight = Color(0xFFD8B3B1);
  static const Color accentRoseSoft = Color(0xFFF8F1EE);
  static const Color accentRoseBorder = Color(0xFFC49290);
  static const Color secondary = accentRose;
  static const Color secondaryLight = accentRoseLight;

  // Background & Surface
  static const Color backgroundLight = Color(0xFFFAF7F2);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardSelectedBg = Color(0xFFF8F1EE);
  static const Color borderLight = Color(0xFFEDE6E1);
  static const Color cardBorder = borderLight;
  static const Color cardBorderSelected = Color(0xFFC49290);

  // Dark Theme Equivalents
  static const Color backgroundDark = Color(0xFF14100E);
  static const Color surfaceDark = Color(0xFF1E1815);
  static const Color cardDark = Color(0xFF27201D);
  static const Color borderDark = Color(0xFF3D332D);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF241812);
  static const Color textSecondaryLight = Color(0xFF766E68);
  static const Color textMuted = Color(0xFF9E9690);
  static const Color textPrimaryDark = Color(0xFFFBF8F5);
  static const Color textSecondaryDark = Color(0xFFB5ACA5);

  // Progress Bar
  static const Color progressActive = Color(0xFFA85D5B);
  static const Color progressInactive = Color(0xFFE8E0DA);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF29B6F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3D2D24),
      Color(0xFF261C16),
    ],
  );

  static const LinearGradient roseGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD8B3B1),
      Color(0xFFA85D5B),
    ],
  );
}
