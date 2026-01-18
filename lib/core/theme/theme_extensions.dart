import 'package:flutter/material.dart';
import 'app_colors.dart';

extension ThemeContextExtension on BuildContext {
  AppColors get colors {
    return Theme.of(this).extension<AppColors>() ?? AppColors.dark;
  }

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;
}