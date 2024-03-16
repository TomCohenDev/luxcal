// import 'dart:convert';

// import '../../../../test/temp/pages/add_event/event.dart';
// import 'package:http/http.dart' as http;

// Future<List<EventItem>> fetchHolidays(int year) async {
//   final response = await http.get(Uri.parse(
//       'https://www.hebcal.com/hebcal?v=1&cfg=json&maj=on&year=$year&month=x'));

//   if (response.statusCode == 200) {
//     final jsonResponse = json.decode(response.body);
//     final eventResponse = EventResponse.fromJson(jsonResponse);
//     return eventResponse.items;
//   } else {
//     throw Exception('Failed to fetch holidays');
//   }
// }
