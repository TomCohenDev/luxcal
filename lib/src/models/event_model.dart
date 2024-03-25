import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventModel {
  final String id;
  final String? title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? location;
  final Color? color;
  final String? imageUrl;
  final String? authorId;
  final String? authorName; // New field for author name
  final String? authorNickname; // New field for author nickname

  EventModel({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.location,
    required this.color,
    this.imageUrl,
    this.authorId,
    this.authorName, // New field
    this.authorNickname, // New field
  });

  // Factory constructor to create an EventModel from a Firestore document
  factory EventModel.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return EventModel(
      id: firestoreDoc['id'] as String,
      title: firestoreDoc['title'] as String?,
      imageUrl: firestoreDoc['imageUrl'] as String?,
      description: firestoreDoc['description'] as String?,
      startDate: (firestoreDoc['startDate'] as Timestamp).toDate(),
      endDate: (firestoreDoc['endDate'] as Timestamp).toDate(),
      location: firestoreDoc['location'] as String?,
      color:
          firestoreDoc['color'] != null ? Color(firestoreDoc['color']) : null,
      authorId: firestoreDoc['authorId'] as String,
      authorName: firestoreDoc['authorName'] as String, // New field
      authorNickname: firestoreDoc['authorNickname'] as String, // New field
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return EventModel(
      id: '',
      title: json['title'],
      description: json['memo'],
      startDate: DateTime.parse(json['date']),
      endDate: DateTime.parse(json['date']),
      color: Color.fromARGB(255, 7, 85, 255),
    );
  }

  // Convert an EventModel instance to a Map, for uploading to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'location': location,
      'color': color?.value,
      'authorId': authorId,
      'authorName': authorName, // New field
      'authorNickname': authorNickname, // New field
    };
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    Color? color,
    String? imageUrl,
    String? authorId,
    String? authorName,
    String? authorNickname,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      color: color ?? this.color,
      imageUrl: imageUrl ?? this.imageUrl,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorNickname: authorNickname ?? this.authorNickname,
    );
  }

  static TimeOfDay _stringToTimeOfDay(String? timeString) {
    final timeParts = timeString?.split(':').map(int.parse).toList();
    return TimeOfDay(hour: timeParts?[0] ?? 0, minute: timeParts?[1] ?? 0);
  }
}
