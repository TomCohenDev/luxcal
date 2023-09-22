import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // static final AppTheme colors = ColorPalette._();
  AppColors._();

  static const Color bannerColor = Color(0xFF795ad9);
  static const Color bannerLightColor = Color(0xFF7f60df);
  static const Color bannerTextTitleColor = Colors.white;
  static const Color cardColor = Colors.white;
  static const Color backgroundColor = Color(0xFFf7f7f7);
  static const Color buttonColor = Color(0xFF7d54cd);
  static const Color buttonTextColor = Colors.white;
  static const Color textFieldHintTextColor = Color(0xFF646464);
  static const Color textFieldTextColor = Color(0xFF646464);
  static const Color cardTextColor = Color(0xFF646464);
  static const Color cardTitleTextColor = Color(0xFF646464);
}

class AppTypography {
  static const _defaultFontFamily = 'Open Sans';
  static const _appNameFont = 'Orbitron';

  AppTypography._();

  // AppTypography(this.theme);

  static TextStyle get bannerTitle => GoogleFonts.getFont(
        _defaultFontFamily,
        color: AppColors.bannerTextTitleColor,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );

  static TextStyle get textfieldText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: const Color(0xFF646464),
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
  static TextStyle get textfieldHintText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: const Color(0xFF646464),
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );

  static TextStyle get buttonText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: AppColors.buttonTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
}
