// final themeBloc = BlocProvider.of<ThemeBloc>(context);
// themeBloc.add(ThemeEvent.toggleDark),

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revampedai/aaacore/theme/app_colors.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';

class AppTheme {
  //
  // Light theme
  //

  static final light = ThemeData.light().copyWith(
    extensions: [
      _lightAppColors,
    ],
  );

  static final _lightAppColors = AppColorsExtension(
    background: AppPalette.white,
    primary: AppPalette.ultramarine_blue,
    onPrimary: AppPalette.white,
    secondary: AppPalette.pink_lemonade,
    onSecondary: AppPalette.ultramarine_blue,
    surface: AppPalette.white,
    onBackground: AppPalette.grey,
    onSurface: AppPalette.ultramarine_blue,
    error: const Color(0xffb00020),
    onError: Colors.white,
  );

  //
  // Dark theme
  //

  static final dark = ThemeData.dark().copyWith(
    extensions: [
      _darkAppColors,
    ],
  );

  static final _darkAppColors = AppColorsExtension(
    primary: const Color(0xffbb86fc),
    onPrimary: Colors.black,
    secondary: const Color(0xff03dac6),
    onSecondary: Colors.black,
    error: const Color(0xffcf6679),
    onError: Colors.black,
    background: const Color(0xff121212),
    onBackground: Colors.white,
    surface: const Color(0xff121212),
    onSurface: Colors.white,
  );
}

extension ThemeGetter on BuildContext {
  // Usage example: `context.theme`
  ThemeData get theme => Theme.of(this);
}
