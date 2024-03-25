import 'dart:convert';

import 'package:LuxCal/src/models/event_model.dart';

import 'package:http/http.dart' as http;

Future<List<EventModel>> fetchHolidays(int year) async {
  final response = await http.get(Uri.parse(
      'https://www.hebcal.com/hebcal?v=1&cfg=json&maj=on&year=$year&month=x'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    // Assuming your JSON structure has an array of events under some key.
    // Adjust 'items' or 'events' based on your actual JSON structure.
    List<dynamic> eventsJson = jsonResponse['items'];

    // Map each JSON event to an EventModel
    List<EventModel> events =
        eventsJson.map((jsonEvent) => EventModel.fromJson(jsonEvent)).toList();

    return events;
  } else {
    throw Exception('Failed to fetch holidays');
  }
}
