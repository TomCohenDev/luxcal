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
  final String authorId; // New field

  EventModel({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.location,
    required this.color,
    this.imageUrl,
    required this.authorId, // New field
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
      authorId: firestoreDoc['authorId'] as String, // New field
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
      'authorId': authorId, // New field
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
    String? authorId, // New field
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
      authorId: authorId ?? this.authorId, // New field
    );
  }

  static TimeOfDay _stringToTimeOfDay(String? timeString) {
    final timeParts = timeString?.split(':').map(int.parse).toList();
    return TimeOfDay(hour: timeParts?[0] ?? 0, minute: timeParts?[1] ?? 0);
  }
}
