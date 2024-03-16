import 'dart:async';

import 'package:LuxCal/src/models/news_model.dart'; // Ensure this import path is correct
import 'package:LuxCal/src/models/event_model.dart'; // Assuming you have an Event model; add this import if needed
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarState.initial()) {
    on<DaySelected>(_onDaySelected);
    on<YearSelected>(_onYearSelected);
    on<ChangeTab>(_onChangeTab);
  }

  void _onDaySelected(DaySelected event, Emitter<CalendarState> emit) {
    emit(state.copyWith(
        selectedDay: event.selectedDay, focusedDay: event.focusedDay));
  }

  void _onYearSelected(YearSelected event, Emitter<CalendarState> emit) {
    emit(state.copyWith(focusedDay: event.focusedDay));
  }

  FutureOr<void> _onChangeTab(ChangeTab event, Emitter<CalendarState> emit) {
    emit(state.copyWith(tab: event.tab));
  }
}
