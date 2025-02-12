import 'dart:typed_data';
import 'dart:html' as html;
import 'package:dio/dio.dart';

/// Downloads the image from [url] as bytes and triggers a browser download.
/// Ensures the file is saved with a valid image extension (jpg/png/gif).
Future<void> saveNetworkImage(String url, String fileName) async {
  // 1. Download image bytes (and get headers).
  final response = await Dio().get<List<int>>(
    url,
    options: Options(responseType: ResponseType.bytes),
  );
  final bytes = Uint8List.fromList(response.data!);

  // 2. Check the Content-Type header to guess file extension.
  final contentType = response.headers.value('content-type') ?? 'image/jpeg';
  String extension;
  if (contentType.contains('png')) {
    extension = 'png';
  } else if (contentType.contains('gif')) {
    extension = 'gif';
  } else {
    // Default to JPEG for anything else (including image/jpeg).
    extension = 'jpg';
  }

  // 3. Ensure fileName has the extension (strip query params if present).
  //    If fileName is "image" or "abc123", append ".jpg" or ".png".
  //    If it already has a valid extension, keep it.
  //    This logic is minimal; you can make it more robust if needed.
  final nameParts = fileName.split('?').first.split('.');
  if (nameParts.length < 2) {
    fileName = '$fileName.$extension';
  } else {
    // If there's an extension but it's not recognized, override it
    final existingExt = nameParts.last.toLowerCase();
    if (!['jpg', 'jpeg', 'png', 'gif'].contains(existingExt)) {
      fileName = '${nameParts.first}.$extension';
    } else {
      fileName = nameParts.join('.'); // Keep the original extension
    }
  }

  // 4. Create a Blob with the correct Content-Type.
  final blob = html.Blob([bytes], contentType);

  // 5. Create an object URL for the blob.
  final blobUrl = html.Url.createObjectUrlFromBlob(blob);

  // 6. Create an anchor element, set its download attribute, and click it.
  final anchor = html.AnchorElement(href: blobUrl)
    ..setAttribute('download', fileName)
    ..click();

  // 7. Clean up the object URL.
  html.Url.revokeObjectUrl(blobUrl);
}
