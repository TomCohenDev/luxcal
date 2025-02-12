// download_utils_mobile.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

/// Downloads the image from [url] to a temporary file, then saves it to the gallery.
Future<void> saveNetworkImage(String url, String fileName) async {
  // Get a temporary directory.
  final tempDir = await getTemporaryDirectory();
  final filePath = '${tempDir.path}/$fileName';

  // Download the file using Dio.
  await Dio().download(url, filePath);

  // Save the file to the gallery using SaverGallery.
  final result = await SaverGallery.saveFile(
    file: filePath,
    name: fileName,
    androidRelativePath: 'Download',
    androidExistNotSave: false,
  );

  if (!result.isSuccess) {
    throw Exception(result.errorMessage);
  }
}
