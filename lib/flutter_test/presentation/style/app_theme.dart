import 'package:flutter/material.dart';
import 'package:machine_test02/flutter_test/presentation/style/app_colors.dart';

class AppTheme {
  static ThemeData getThemeData() => ThemeData(
      primarySwatch: Colors.blue,
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor),
          titleSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)));
}
