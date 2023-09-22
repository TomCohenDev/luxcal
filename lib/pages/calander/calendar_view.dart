import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

import '../add_event/event.dart';
import '../../backend/records/event_record.dart';
import '../../backend/records/serializers.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  int previewsYear = DateTime.now().year;
  List<CalendarEventData<Event>> _events = [];

  void initState() {
    super.initState();

    // Fetch holidays
    fetchHolidays(_focusedDay.year).then((items) {
      setState(() {
        _events = generateEvents(items);
        for (var event in _events) {
          CalendarControllerProvider.of(context).controller.add(event);
        }
      });
    });

    // Fetch Firestore events
    fetchEventsFromFirestore().then((firestoreEvents) {
      final calendarEvents = convertFirestoreEventsToCalendar(firestoreEvents);
      setState(() {
        _events.addAll(calendarEvents);
        for (var event in calendarEvents) {
          CalendarControllerProvider.of(context).controller.add(event);
        }
      });
    });
  }

  Future<List<EventItem>> fetchHolidays(int year) async {
    final response = await http.get(Uri.parse(
        'https://www.hebcal.com/hebcal?v=1&cfg=json&maj=on&year=$year&month=x'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final eventResponse = EventResponse.fromJson(jsonResponse);
      return eventResponse.items;
    } else {
      throw Exception('Failed to fetch holidays');
    }
  }

  Future<List<EventRecord>> fetchEventsFromFirestore() async {
    final querySnapshot = await EventRecord.collection.get();
    return querySnapshot.docs.map((doc) {
      return serializers.deserializeWith(
          EventRecord.serializer, serializedData(doc))!;
    }).toList();
  }

  List<CalendarEventData<Event>> convertFirestoreEventsToCalendar(
      List<EventRecord> records) {
    return records.map((record) {
      return CalendarEventData<Event>(
        date: record.startdate!, // Assuming every event has a start date.
        endDate: record.enddate,
        color: Color(int.parse(record.color!)),
        description: record.description!,
        endTime: record.endtime,
        startTime: record.starttime,
        title: record.title!,
        event: Event(
          title: record.title!,
          // Add other fields if necessary.
        ),
      );
    }).toList();
  }

  List<CalendarEventData<Event>> generateEvents(List<EventItem> items) {
    return items.map((item) {
      final DateTime eventDate = DateTime.parse(item.date);
      return CalendarEventData<Event>(
        date: eventDate,
        title: item.title,
        event: Event(
          title: item.title,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jewish Calendar App'),
      ),
      body: MonthView(
        onPageChange: (date, page) {
          if ((date.year > previewsYear)) {
            print(date);
            previewsYear = date.year;
            fetchHolidays(date.year).then((items) {
              setState(() {
                _events = generateEvents(items);
                // Add the events to the CalendarController
                for (var event in _events) {
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
