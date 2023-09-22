import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'serializers.dart';

part 'event_record.g.dart';

abstract class EventRecord implements Built<EventRecord, EventRecordBuilder> {
  static Serializer<EventRecord> get serializer => _$eventRecordSerializer;

  String? get title;
  DateTime? get startdate;
  DateTime? get enddate;
  DateTime? get starttime;
  DateTime? get endtime;
  String? get color;
  DateTime? get created_date;

  String? get imageUrl;
  String? get location;
  String? get description;
  String? get event_creator;
  

  EventRecord._(); // private constructor

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<EventRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  factory EventRecord([void Function(EventRecordBuilder)? updates]) =
      _$EventRecord;
}

Map<String, dynamic> createEventRecordData({
  String? title,
  DateTime? startdate,
  DateTime? enddate,
  DateTime? starttime,
  DateTime? endtime,
  String? color,
  DateTime? created_date,
  String? imageUrl,
  String? location,
  String? description,
  String? event_creator,
}) {
  final firestoreData = serializers.toFirestore(
    EventRecord.serializer,
    EventRecord(
      (e) => e
        ..title = title
        ..startdate = startdate
        ..enddate = enddate
        ..starttime = starttime
        ..endtime = endtime
        ..color = color
        ..created_date = created_date
        ..imageUrl = imageUrl
        ..location = location
        ..description = description
        ..event_creator = event_creator,
    ),
  );

  return firestoreData;
}
