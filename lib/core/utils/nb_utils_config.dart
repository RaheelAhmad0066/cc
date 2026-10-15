import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../constants/app_colors.dart';

class NbUtilsConfig {
  NbUtilsConfig._();

  /// Initialize nb_utils shared preferences and settings
  static Future<void> init() async {
    await initialize();
    
    // Set custom defaults for toast notifications
    defaultToastBackgroundColor = AppColors.primaryDark;
    defaultToastTextColor = Colors.white;
    defaultRadius = 12.0;
  }
}

