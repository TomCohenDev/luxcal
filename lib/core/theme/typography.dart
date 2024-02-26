import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';
import 'package:revampedai/aaacore/theme/theme.dart';

abstract class AppTypography {
  static final loadingScreenText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 28,
    color: AppPalette.ultramarine_blue,
    fontWeight: FontWeight.bold,
  );

  static final textButtonText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 13,
    color: AppPalette.ultramarine_blue,
    fontWeight: FontWeight.bold,
  );

  static final drodpdownText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 24,
    color: AppPalette.pink_lemonade,
    fontWeight: FontWeight.bold,
  );

  static final dropdownBottomText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 12,
    color: AppPalette.pink_lemonade,
    fontWeight: FontWeight.normal,
  );

  static final dialogTitle = GoogleFonts.getFont(
    "Poppins",
    fontSize: 25,
    color: AppPalette.black,
    fontWeight: FontWeight.w500,
  );

  static final switchSelected = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.white,
    fontWeight: FontWeight.w500,
  );

  static final switchUnselected = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.ultramarine_blue,
    fontWeight: FontWeight.w500,
  );

  static final appBarTitle = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.white,
    fontWeight: FontWeight.w500,
  );
  static final appBarButtons = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.white,
    fontWeight: FontWeight.w300,
  );

  static final logo = GoogleFonts.getFont(
    "Poppins",
    fontSize: 32,
    color: AppPalette.ultramarine_blue,
    fontWeight: FontWeight.bold,
  );

  static final textFieldText = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.ultramarine_blue,
    fontWeight: FontWeight.w500,
  );

  static final textFieldLabel = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    color: AppPalette.ultramarine_blue,
    fontWeight: FontWeight.w300,
  );

  static final link = GoogleFonts.getFont(
    "Poppins",
    color: AppPalette.pink_lemonade,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final body16 = GoogleFonts.getFont(
    "Poppins",
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppPalette.grey.shade800,
  );

  static final body18 = GoogleFonts.getFont(
    "Poppins",
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppPalette.grey.shade800,
  );
  static final body22 = GoogleFonts.getFont(
    "Poppins",
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppPalette.white,
  );

  static final uploadPictureTutorial = GoogleFonts.getFont(
    "Poppins",
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppPalette.ultramarine_blue,
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
    return RevampedTextStyle();
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
