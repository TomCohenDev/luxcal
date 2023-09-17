import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxcal_app/utils/theme.dart';

final _defaultFontFamily = 'Open Sans';
final _appNameFont = 'Orbitron';

// Define your text styles here
final TextStyle titleStyle_title = GoogleFonts.getFont(
  _defaultFontFamily,
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 40.0,
);

final TextStyle titleStyle_appname = GoogleFonts.getFont(
  _appNameFont,
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 70.0,
);
