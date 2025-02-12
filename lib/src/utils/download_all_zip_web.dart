// utils/download_all_zip_web.dart
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Downloads [imageUrls], zips them in memory, and triggers a browser download.
Future<void> downloadAllImagesAsZip(
  List<String> imageUrls, {
  String zipName = 'images.zip',
}) async {
  // 1. Create an in-memory Archive.
  final archive = Archive();

  // 2. Download each image as bytes and add to the archive.
  for (final url in imageUrls) {
    final response = await Dio().get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = response.data!;
    final fileName = _deriveFileName(url);
    archive.addFile(ArchiveFile(fileName, bytes.length, bytes));
  }

  // 3. Encode the archive as a zip.
  final zippedBytes = ZipEncoder().encode(archive);
  if (zippedBytes == null) {
    throw Exception('Failed to encode ZIP archive');
  }

  // 4. Create a Blob with the zipped bytes.
  final blob = html.Blob([Uint8List.fromList(zippedBytes)], 'application/zip');

  // 5. Create a temporary object URL for the blob.
  final blobUrl = html.Url.createObjectUrlFromBlob(blob);

  // 6. Trigger a download via an anchor element.
  final anchor = html.AnchorElement(href: blobUrl)
    ..setAttribute('download', zipName)
    ..click();

  // 7. Clean up.
  html.Url.revokeObjectUrl(blobUrl);
}

/// Derives a file name from the image URL.
String _deriveFileName(String url) {
  // Remove query parameters if any, then grab the last path segment.
  final noQuery = url.split('?').first;
  final segments = noQuery.split('/');
  final rawName = segments.isNotEmpty ? segments.last : 'image';
  // If it doesn't have an extension, add .jpg as a fallback.
  if (!rawName.contains('.')) {
    return '$rawName.jpg';
  }
  return rawName;
}
