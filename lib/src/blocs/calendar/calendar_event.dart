part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class DaySelected extends CalendarEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;

  DaySelected({required this.selectedDay, required this.focusedDay});

  @override
  List<Object> get props => [selectedDay, focusedDay];
}

class ChangeTab extends CalendarEvent {
  final CalendarTabs tab;

  ChangeTab({required this.tab});

  @override
  List<Object> get props => [tab];
}

class MonthSelected extends CalendarEvent {
  final DateTime focusedDay;

  MonthSelected({required this.focusedDay});

  @override
  List<Object> get props => [focusedDay];
}

class YearSelected extends CalendarEvent {
  final DateTime focusedDay;

  YearSelected({required this.focusedDay});

  @override
  List<Object> get props => [focusedDay];
}

class FormatChanged extends CalendarEvent {
  final CalendarFormat format;

  const FormatChanged(this.format);

  @override
  List<Object> get props => [format];
}
