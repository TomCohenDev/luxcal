// utils/download_all_zip_mobile.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

/// Downloads [imageUrls], zips them in memory, and saves the ZIP to the device.
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

  // 4. Write the ZIP to a temporary file.
  final tempDir = await getTemporaryDirectory();
  final zipPath = '${tempDir.path}/$zipName';
  final zipFile = File(zipPath);
  await zipFile.writeAsBytes(zippedBytes, flush: true);

  // 5. Use SaverGallery to save the ZIP file in the "Download" folder.
  final result = await SaverGallery.saveFile(
    file: zipPath,
    name: zipName,
    androidRelativePath: 'Download',
    androidExistNotSave: false,
  );

  if (!result.isSuccess) {
    throw Exception('Error saving ZIP: ${result.errorMessage}');
  }
}

/// Derives a file name from the image URL.
String _deriveFileName(String url) {
  final noQuery = url.split('?').first;
  final segments = noQuery.split('/');
  final rawName = segments.isNotEmpty ? segments.last : 'image';
  if (!rawName.contains('.')) {
    return '$rawName.jpg';
  }
  return rawName;
}
