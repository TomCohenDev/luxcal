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

Future<String> fetchHebrewMonthForDay(int year, int month, int day) async {
  // Constructing the URL with the given year, month, and day
  final url = Uri.parse(
      'https://www.hebcal.com/converter?cfg=json&gy=$year&gm=$month&gd=$day&g2h=1&strict=1');

  // Making the GET request
  final response = await http.get(url);

  // Check if the request was successful
  if (response.statusCode == 200) {
    // Parse the JSON response
    final jsonResponse = json.decode(response.body);

    // Extracting the Hebrew month name
    final String hebrewMonth = jsonResponse['hm'];

    // Optionally, you can also return the full Hebrew date string if needed
    // final String hebrewDate = jsonResponse['hebrew'];

    return hebrewMonth;
  } else {
    // If the request failed, throw an exception with the error
    throw Exception('Failed to fetch Hebrew month for $year-$month-$day');
  }
}
