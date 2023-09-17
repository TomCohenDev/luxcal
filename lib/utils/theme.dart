// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    return LightModeTheme();
  }

  late Color bannerColor;
  late Color bannerLightColor;

  late Color cardColor;
  late Color cardTextColor;
  late Color cardTitleTextColor;

  late Color backgroundColor;
  late Color buttonColor;
  late Color buttonTextColor;

  late Color textFieldHintTextColor;
  late Color textFieldTextColor;

  String get title1Family => typography.textFieldTextFamily;
  TextStyle get title1 => typography.textFieldText;
  String get title2Family => typography.textFieldHintFamily;
  TextStyle get title2 => typography.textFieldHint;
  String get title3Family => typography.cardTextFamily;
  TextStyle get title3 => typography.cardText;
  String get subtitle1Family => typography.buttonTextFamily;
  TextStyle get subtitle1 => typography.buttonText;
  String get subtitle2Family => typography.cardTitleTextFamily;
  TextStyle get subtitle2 => typography.cardTitleText;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends AppTheme {
  final Color bannerColor = const Color(0xFF795ad9);
  final Color bannerLightColor = const Color(0xFF7f60df);

  final Color cardColor = Colors.white;

  final Color backgroundColor = const Color(0xFFf7f7f7);
  final Color buttonColor = const Color(0xFF7d54cd);

  final Color buttonTextColor = Colors.white;
  final Color textFieldHintTextColor = const Color(0xFF646464);
  final Color textFieldTextColor = const Color(0xFF646464);
  final Color cardTextColor = const Color(0xFF646464);
  final Color cardTitleTextColor = const Color(0xFF646464);
}

abstract class Typography {
  String get textFieldTextFamily;
  TextStyle get textFieldText;

  String get textFieldHintFamily;
  TextStyle get textFieldHint;

  String get cardTextFamily;
  TextStyle get cardText;

  String get buttonTextFamily;
  TextStyle get buttonText;

  String get cardTitleTextFamily;
  TextStyle get cardTitleText;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;
  final _defaultFontFamily = 'Lexend Deca';



  String get textFieldTextFamily => _defaultFontFamily;
  TextStyle get textFieldText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: theme.textFieldTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get textFieldHintFamily => _defaultFontFamily;
  TextStyle get textFieldHint => GoogleFonts.getFont(
        _defaultFontFamily,
        color: theme.textFieldHintTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get cardTextFamily => _defaultFontFamily;
  TextStyle get cardText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: theme.cardTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      );
  String get buttonTextFamily => _defaultFontFamily;
  TextStyle get buttonText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: theme.buttonTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );
  String get cardTitleTextFamily => _defaultFontFamily;
  TextStyle get cardTitleText => GoogleFonts.getFont(
        _defaultFontFamily,
        color: theme.cardTitleTextColor,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    Paint? foreground,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    Color? decorationColor,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              decorationColor: decorationColor,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              foreground: foreground,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              decorationColor: decorationColor,
              height: lineHeight,
            );
}
