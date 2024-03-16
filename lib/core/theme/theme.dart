// final themeBloc = BlocProvider.of<ThemeBloc>(context);
// themeBloc.add(ThemeEvent.toggleDark),

import 'package:LuxCal/core/theme/app_colors.dart';
import 'package:LuxCal/core/theme/pallette.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppPalette.tuna,
      
    );
  }
}

extension ThemeGetter on BuildContext {
  // Usage example: `context.theme`
  ThemeData get theme => Theme.of(this);
}
