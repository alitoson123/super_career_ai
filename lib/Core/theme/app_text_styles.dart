import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';

class AppTextStyles {
  // Global Font Family Constant
  static const String _fontFamily =
      'Inter'; // Change this if you use exactly GoogleFonts or a local font

  /// Unified Base TextStyle Factory
  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    Color color = AppColors.textPrimary,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize.sp, // Automatically handled by flutter_screenutil
      fontWeight: fontWeight,
      color: color,
    );
  }

  // ---------------------------------------------------------------------------
  // Headlines: Large sizes for prominent titles (e.g. Welcome Back, Onboarding)
  // ---------------------------------------------------------------------------
  static TextStyle get headlineLarge =>
      _base(fontSize: 32, fontWeight: FontWeight.bold);
  static TextStyle get headlineMedium =>
      _base(fontSize: 28, fontWeight: FontWeight.bold);
  static TextStyle get headlineSmall =>
      _base(fontSize: 24, fontWeight: FontWeight.bold);

  // ---------------------------------------------------------------------------
  // Titles: AppBar titles, Dialog headers, Section Titles (Sizes: 16 - 22)
  // ---------------------------------------------------------------------------
  static TextStyle get titleLarge =>
      _base(fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle get titleMedium =>
      _base(fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle get titleSmall =>
      _base(fontSize: 16, fontWeight: FontWeight.w600);

  // ---------------------------------------------------------------------------
  // Body: Regular readable text blocks, descriptions (Sizes: 12 - 16)
  // Defaulting to AppColors.textSecondary for reading paragraphs
  // ---------------------------------------------------------------------------
  static TextStyle get bodyLarge => _base(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  static TextStyle get bodyMedium => _base(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  static TextStyle get bodySmall => _base(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // ---------------------------------------------------------------------------
  // Labels: Small/Medium bold text for buttons, chips, tags, inputs
  // Defaulting to AppColors.textPrimary for buttons
  // ---------------------------------------------------------------------------
  static TextStyle get labelLarge =>
      _base(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle get labelMedium =>
      _base(fontSize: 12, fontWeight: FontWeight.w600);
  static TextStyle get labelSmall => _base(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );
}
