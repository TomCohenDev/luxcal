part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loadingInfo, loaded, error }

enum CalendarTabs { upcoming, news, selected }

class CalendarState extends Equatable {
  final CalendarStatus status;
  final List<Event>? events; // Assuming Event is a defined class
  final List<News>? news; // Assuming News is a defined class
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final String? errorMessage;
  final CalendarTabs tab;

  const CalendarState({
    this.status = CalendarStatus.initial,
    this.events,
    this.news,
    required this.selectedDay,
    required this.focusedDay,
    this.calendarFormat = CalendarFormat.month,
    this.errorMessage,
    this.tab = CalendarTabs.upcoming,
  });

  factory CalendarState.initial() {
    return CalendarState(
      status: CalendarStatus.initial,
      focusedDay: DateTime.now(),
      selectedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      tab: CalendarTabs.upcoming,
    );
  }

  CalendarState copyWith({
    CalendarStatus? status,
    List<Event>? events,
    List<News>? news,
    DateTime? selectedDay,
    DateTime? focusedDay,
    CalendarFormat? calendarFormat,
    String? errorMessage,
    CalendarTabs? tab,
  }) {
    return CalendarState(
      status: status ?? this.status,
      events: events ?? this.events,
      news: news ?? this.news,
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      errorMessage: errorMessage ?? this.errorMessage,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object?> get props => [
        status,
        events,
        news,
        selectedDay,
        focusedDay,
        calendarFormat,
        errorMessage,
        tab,
      ];
}
