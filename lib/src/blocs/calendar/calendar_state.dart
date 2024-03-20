part of 'calendar_bloc.dart';

enum CalendarStatus { initial, loadingInfo, loaded, error }

enum CalendarTabs { upcoming, news, selected }

class CalendarState extends Equatable {
  final CalendarStatus status;
  final List<EventModel>? events; // Assuming Event is a defined class
  final List<NewsModel>? news; // Assuming News is a defined class
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final String? errorMessage;
  final CalendarTabs tab;
  final List<UserModel>? contacts;

  const CalendarState({
    this.status = CalendarStatus.initial,
    this.events,
    this.news,
    required this.selectedDay,
    required this.focusedDay,
    this.calendarFormat = CalendarFormat.month,
    this.errorMessage,
    this.tab = CalendarTabs.upcoming,
    this.contacts,
  });

  factory CalendarState.initial() {
    return CalendarState(
      status: CalendarStatus.initial,
      focusedDay: DateTime.now(),
      selectedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      tab: CalendarTabs.upcoming,
      news: [],
      events: [],
      contacts: [],
    );
  }

  CalendarState copyWith({
    CalendarStatus? status,
    List<EventModel>? events,
    List<NewsModel>? news,
    DateTime? selectedDay,
    DateTime? focusedDay,
    CalendarFormat? calendarFormat,
    String? errorMessage,
    CalendarTabs? tab,
    List<UserModel>? contacts,
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
      contacts: contacts ?? this.contacts,
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
        contacts,
      ];
}
