// lib/src/ui/widgets/export_user_data_web.dart
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:dio/dio.dart';

/// Example: Downloads some user data as a text file using dart:html.
Future<void> exportUserData() async {
  // For example, fetch some data (here we simulate with a string)
  final data = "User data: ...";
  // Convert the data to bytes.
  final bytes = Uint8List.fromList(data.codeUnits);
  // Create a blob from the bytes.
  final blob = html.Blob([bytes], 'text/plain');
  // Create an object URL for the blob.
  final url = html.Url.createObjectUrlFromBlob(blob);
  // Create an anchor element, set its download attribute, and click it.
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', 'user_data.txt')
    ..click();
  // Clean up the object URL.
  html.Url.revokeObjectUrl(url);
}
