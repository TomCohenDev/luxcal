import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? timestampToDateTime(dynamic value) {
  if (value is Timestamp) {
    return value.toDate();
  }
  return null; // Return null if value is not a Timestamp
}
