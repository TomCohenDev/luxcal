import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../backend/records/event_record.dart';
import '../../backend/records/serializers.dart';
import '../add_event/event.dart';
import 'package:http/http.dart' as http;

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
      // endTime: record.endtime,
      startTime: record.startdate,
      title: record.title!,
      event: Event(
        title: record.title!,
        // Add other fields if necessary.
      ),
    );
  }).toList();
}

List<CalendarEventData<Event>> generateEventsFromHolidays(
    List<EventItem> items) {
  return items.map((item) {
    final DateTime eventDate = DateTime.parse(item.date);
    return CalendarEventData<Event>(
      date: eventDate,
      title: item.title,
      startTime: eventDate,
      event: Event(
        title: item.title,
      ),
    );
  }).toList();
}
