import 'package:calendar_view/calendar_view.dart';

import 'package:flutter/material.dart';
import 'package:LuxCal/widgets/custom/model.dart';

import '../add_event/event.dart';

class CalendarModel extends CustomModel {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  int previewsYear = DateTime.now().year;
  List<CalendarEventData<Event>> events = [];
  // late EventController<Object?> calendarProvider;

  @override
  void initState(BuildContext context) {
    // calendarProvider = CalendarControllerProvider.of(context).controller;
  }

  @override
  void dispose() {}

  /// Additional helper methods are added here.
}
