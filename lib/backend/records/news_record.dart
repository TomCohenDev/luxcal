import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'serializers.dart';
part 'news_record.g.dart';

abstract class NewsRecord implements Built<NewsRecord, NewsRecordBuilder> {
  static Serializer<NewsRecord> get serializer => _$newsRecordSerializer;

  String? get headline;
  DateTime? get publishedDate;
  String? get author;
  String? get content;

  NewsRecord._(); // private constructor

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('news');

  static Stream<NewsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<NewsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  factory NewsRecord([void Function(NewsRecordBuilder)? updates]) =
      _$NewsRecord;
}

Map<String, dynamic> createNewsRecordData({
  String? headline,
  DateTime? publishedDate,
  String? author,
  String? content,
}) {
  final firestoreData = serializers.toFirestore(
    NewsRecord.serializer,
    NewsRecord(
      (n) => n
        ..headline = headline
        ..publishedDate = publishedDate
        ..author = author
        ..content = content,
    ),
  );

  return firestoreData;
}
