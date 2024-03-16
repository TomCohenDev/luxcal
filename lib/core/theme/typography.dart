import 'package:LuxCal/core/theme/pallette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static final eventsWidgetText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 18,
    color: Color.fromARGB(255, 255, 255, 255),
    fontWeight: FontWeight.w600,
  );

  static final dayoftheweek = GoogleFonts.getFont(
    "Poppins",
    fontSize: 14,
    color: Color.fromARGB(98, 255, 255, 255),
    fontWeight: FontWeight.w400,
  );
  static final calendarDays = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.white,
    fontWeight: FontWeight.w400,
  );

  static final calendarTitle = GoogleFonts.getFont(
    "Poppins",
    fontSize: 28,
    color: AppPalette.white,
    fontWeight: FontWeight.w400,
  );

  static final buttonText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 20,
    color: AppPalette.white,
    fontWeight: FontWeight.bold,
  );

  static final textFieldText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.white,
    fontWeight: FontWeight.bold,
  );

  static final textFieldHint = GoogleFonts.getFont(
    "Poppins",
    fontSize: 18,
    color: AppPalette.white,
    fontWeight: FontWeight.bold,
  );

  static final loginHeader = GoogleFonts.getFont(
    "Poppins",
    fontSize: 40,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static final forgotPassTxt = GoogleFonts.getFont(
    "Poppins",
    fontSize: 14,
    color: AppPalette.crayola,
    fontWeight: FontWeight.bold,
  );

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
