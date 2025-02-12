// utils/download_all_zip.dart
export 'download_all_zip_stub.dart'
  if (dart.library.html) 'download_all_zip_web.dart'
  if (dart.library.io) 'download_all_zip_mobile.dart';
