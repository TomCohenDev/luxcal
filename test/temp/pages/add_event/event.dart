import 'package:flutter/foundation.dart';

@immutable
class Event {
  final String title;

  const Event({this.title = "Title"});

  @override
  bool operator ==(Object other) => other is Event && title == other.title;


  @override
  String toString() => title;
}

class EventResponse {
  final List<EventItem> items;

  EventResponse({required this.items});

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      items: (json['items'] as List)
          .map((item) => EventItem.fromJson(item))
          .toList(),
    );
  }
}

class EventItem {
  final String title;
  final String date;

  EventItem({required this.title, required this.date});

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      title: json['title'],
      date: json['date'],
    );
  }
}
