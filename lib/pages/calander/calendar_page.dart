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

  getAllEvents() {
    // Fetch holidays
    fetchHolidays(_model.focusedDay.year).then((items) {
      setState(() {
        _model.events = generateEvents(items);
        for (var event in _model.events) {
          CalendarControllerProvider.of(context).controller.add(event);
        }
      });
    });

    // Fetch Firestore events
    fetchEventsFromFirestore().then((firestoreEvents) {
      final calendarEvents = convertFirestoreEventsToCalendar(firestoreEvents);
      setState(() {
        _model.events.addAll(calendarEvents);
        for (var event in calendarEvents) {
          CalendarControllerProvider.of(context).controller.add(event);
        }
      });
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
                _model.events = generateEvents(items);
                // Add the events to the CalendarController
                for (var event in _model.events) {
                  CalendarControllerProvider.of(context).controller.add(event);
                }
              });
            });
          }
        },
        onEventTap: (event, date) {
          print(event);
        },
      ),
    );
  }
}
