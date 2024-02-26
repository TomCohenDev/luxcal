part of 'theme_bloc.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);

  static ThemeState get lightTheme => ThemeState(AppTheme.light);

  static ThemeState get darkTheme => ThemeState(AppTheme.dark);
}
