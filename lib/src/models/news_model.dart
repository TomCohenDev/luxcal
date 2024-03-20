import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String? id;
  final String? headline;
  final String? content;
  final DateTime publicationDate;
  final String author;
  final String? imageUrl;

  NewsModel({
    this.id,
    this.headline,
    this.content,
    required this.publicationDate,
    required this.author,
    this.imageUrl,
  });

  // Factory constructor to create a NewsModel from a Firestore document
  factory NewsModel.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return NewsModel(
      headline: firestoreDoc['headline'],
      imageUrl: firestoreDoc['imageUrl'],
      content: firestoreDoc['content'],
      publicationDate: (firestoreDoc['publicationDate'] as Timestamp).toDate(),
      author: firestoreDoc['author'] as String,
    );
  }

  // Convert a NewsModel instance to a Map, for uploading to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'headline': headline,
      'content': content,
      'publicationDate': Timestamp.fromDate(publicationDate),
      'author': author,
      'imageUrl': imageUrl,
    };
  }

  NewsModel copyWith({
    String? id,
    String? headline,
    String? content,
    DateTime? publicationDate,
    String? author,
    String? imageUrl,
  }) {
    return NewsModel(
      id: id ?? this.id,
      headline: headline ?? this.headline,
      content: content ?? this.content,
      publicationDate: publicationDate ?? this.publicationDate,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
