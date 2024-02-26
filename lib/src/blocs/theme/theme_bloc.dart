import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:revampedai/aaacore/theme/theme.dart';

part 'theme_state.dart';
part 'theme_event.dart';

final GetStorage storage = GetStorage();

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(_initialTheme()) {
    on<ThemeSwitchEvent>((event, emit) {
      bool isDark = storage.read('is_dark') ?? false;
      isDark = !isDark;
      storage.write('is_dark', isDark);
      emit(isDark ? ThemeState.darkTheme : ThemeState.lightTheme);
    });
  }
  static ThemeState _initialTheme() {
    return storage.read('is_dark') ?? false
        ? ThemeState.darkTheme
        : ThemeState.lightTheme;
  }
}
