import 'package:borsum/app/theme/app_theme.dart';
import 'package:borsum/app/theme/color_scheme/app_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppLightTheme implements AppTheme {
  @override
  ThemeData get themeData => ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme: AppColorScheme.lightColorScheme,
        typography: Typography.material2021(),
        scaffoldBackgroundColor: AppColorScheme.lightColorScheme.surface,
        textTheme: textTheme,
      );

  @override
  TextTheme get textTheme => TextTheme(
        bodySmall: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
        displayLarge: TextStyle(
          fontSize: 100.sp,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: 70.sp,
          fontWeight: FontWeight.bold,
        ),
      );
}
