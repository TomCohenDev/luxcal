import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final AppTheme lightMode = LightModeTheme._();

  Color get bannerColor;
  Color get bannerTextTitleColor;
  Color get bannerLightColor;
  Color get cardColor;
  Color get cardTextColor;
  Color get cardTitleTextColor;
  Color get backgroundColor;
  Color get buttonColor;
  Color get buttonTextColor;
  Color get textFieldHintTextColor;
  Color get textFieldTextColor;
}

class LightModeTheme implements AppTheme {
  LightModeTheme._();

  @override
  Color get bannerColor => const Color(0xFF795ad9);
  @override
  Color get bannerLightColor => const Color(0xFF7f60df);
  @override
  Color get bannerTextTitleColor => Colors.white;
  @override
  Color get cardColor => Colors.white;
  @override
  Color get backgroundColor => const Color(0xFFf7f7f7);
  @override
  Color get buttonColor => const Color(0xFF7d54cd);
  @override
  Color get buttonTextColor => Colors.white;
  @override
  Color get textFieldHintTextColor => const Color(0xFF646464);
  @override
  Color get textFieldTextColor => const Color(0xFF646464);
  @override
  Color get cardTextColor => const Color(0xFF646464);
  @override
  Color get cardTitleTextColor => const Color(0xFF646464);
}

class AppThemeTypography {
  static const _defaultFontFamily = 'Open Sans';
  static const _appNameFont = 'Orbitron';

  final AppTheme theme;

  AppThemeTypography(this.theme);

  TextStyle get bannerTitle => GoogleFonts.getFont(
        _defaultFontFamily,
        color: theme.bannerTextTitleColor,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );

  TextStyle get textfieldText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: const Color(0xFF646464),
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
  TextStyle get textfieldHintText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: const Color(0xFF646464),
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );

  TextStyle get buttonText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: theme.buttonTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
}
