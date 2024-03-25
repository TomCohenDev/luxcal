part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class InilaizeCalendar extends CalendarEvent {
  InilaizeCalendar();
}

class AddEvent extends CalendarEvent {
  final EventModel event;
  final XFile? image;

  const AddEvent(this.event, [this.image]);

  @override
  List<Object?> get props => [event, image];
}

class AddNews extends CalendarEvent {
  final NewsModel news;
  final XFile? image;

  const AddNews(this.news, [this.image]);

  @override
  List<Object?> get props => [news, image];
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

class DeleteEvent extends CalendarEvent {
  final String eventId;

  const DeleteEvent({required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class DeleteNews extends CalendarEvent {
  final String newsId;

  const DeleteNews({required this.newsId});

  @override
  List<Object> get props => [newsId];
}

class UpdateEvent extends CalendarEvent {
  final EventModel updatedEvent;
  final XFile? pickedImage;

  const UpdateEvent({required this.updatedEvent, this.pickedImage});

  @override
  List<Object?> get props => [updatedEvent, pickedImage];
}

class UpdateNews extends CalendarEvent {
  final NewsModel updatedNews;
  final XFile? pickedImage;

  const UpdateNews({required this.updatedNews, this.pickedImage});

  @override
  List<Object?> get props => [updatedNews, pickedImage];
}

class GetHolidaysForYear extends CalendarEvent {
  final int year;

  const GetHolidaysForYear({required this.year});

  @override
  List<Object> get props => [year];
}
