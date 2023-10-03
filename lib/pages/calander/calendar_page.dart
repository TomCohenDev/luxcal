import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/custom/model.dart';
import '../add_event/event.dart';
import '../../backend/records/event_record.dart';
import '../../backend/records/serializers.dart';
import 'calendar_logic.dart';
import 'calendar_model.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarModel _model;

  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarModel());

    getAllEvents();
  }

  getAllEvents() async {
    final holidays = await fetchHolidays(_model.focusedDay.year);

    final firestoreEvents = await fetchEventsFromFirestore();
    List<CalendarEventData<Event>> calendarEvents =
        convertFirestoreEventsToCalendar(firestoreEvents);

    setState(() {
      _model.events = generateEventsFromHolidays(holidays);

      calendarEvents = calendarEvents.map((event) {
        print(event.date);
        DateTime normalizedDate =
            DateTime(event.date.year, event.date.month, event.date.day, 0, 0);

        return CalendarEventData<Event>(
          date: normalizedDate,
          title: event.title,
          color: event.color,
          description: event.description,
          endDate: event.endDate,
          endTime: event.endDate,
          event: event.event,
          startTime: normalizedDate,
        );
      }).toList();

      _model.events.addAll(calendarEvents);

      CalendarControllerProvider.of(context).controller.addAll(_model.events);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jewish Calendar App'),
      ),
      body: MonthView(
        onPageChange: (date, page) {
          if ((date.year > _model.previewsYear)) {
            print(date);
            _model.previewsYear = date.year;
            fetchHolidays(date.year).then((items) {
              setState(() {
                _model.events = generateEventsFromHolidays(items);
                // Add the events to the CalendarController
                for (var event in _model.events) {
                  CalendarControllerProvider.of(context).controller.add(event);
                }
              });
            });
          }
        },
        onEventTap: (event, date) {
          print(event.startTime);
        },
      ),
    );
  }
}
