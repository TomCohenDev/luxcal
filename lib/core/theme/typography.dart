import 'package:LuxCal/core/theme/pallette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static final mainButton = GoogleFonts.getFont(
    "Poppins",
    fontSize: 18,
    color: AppPalette.white,
    fontWeight: FontWeight.bold,
  );
}

extension GoogleFontsExtension on GoogleFonts {
  static RevampedTextStyle getFont(String font) {
    return const RevampedTextStyle();
  }
}

class RevampedTextStyle extends TextStyle {
  const RevampedTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) : super(
          fontFamily: 'Poppins',
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
        );
}
