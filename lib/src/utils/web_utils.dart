// // web_utils.dart
// // This file is only used on Web builds (via conditional import).

// import 'dart:typed_data';
// import 'dart:html' as html;

// import 'package:saver_gallery/saver_gallery.dart';

// Future<void> saveImageWeb(Uint8List bytes, String fileName) async {
//   final blob = html.Blob([bytes]);
//   // For example, if your file is .jpg or .png
//   final ext = fileName.contains('.') ? fileName.split('.').last : 'jpg';
//   await SaverGallery.saveFile(
//     blob: blob,
//     fileName: fileName,
//     ext: ext,
//   );
// }
