import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String? id;
  final String? headline;
  final String? content;
  final DateTime publicationDate;
  final String author;
  final String? imageUrl;
  final String authorId;
  final String authorNickname; // New field for author nickname

  NewsModel({
    this.id,
    this.headline,
    this.content,
    required this.publicationDate,
    required this.author,
    this.imageUrl,
    required this.authorId,
    required this.authorNickname, // New field
  });

  // Factory constructor to create a NewsModel from a Firestore document
  factory NewsModel.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return NewsModel(
      id: firestoreDoc['id'],
      headline: firestoreDoc['headline'],
      imageUrl: firestoreDoc['imageUrl'],
      content: firestoreDoc['content'],
      publicationDate: (firestoreDoc['publicationDate'] as Timestamp).toDate(),
      author: firestoreDoc['author'],
      authorId: firestoreDoc['authorId'],
      authorNickname: firestoreDoc['authorNickname'], // New field
    );
  }

  // Convert a NewsModel instance to a Map, for uploading to Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'headline': headline,
      'content': content,
      'publicationDate': Timestamp.fromDate(publicationDate),
      'author': author,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'authorNickname': authorNickname, // New field
    };
  }

  NewsModel copyWith({
    String? id,
    String? headline,
    String? content,
    DateTime? publicationDate,
    String? author,
    String? imageUrl,
    String? authorId,
    String? authorNickname,
  }) {
    return NewsModel(
      id: id ?? this.id,
      headline: headline ?? this.headline,
      content: content ?? this.content,
      publicationDate: publicationDate ?? this.publicationDate,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      authorId: authorId ?? this.authorId,
      authorNickname: authorNickname ?? this.authorNickname,
    );
  }
}
