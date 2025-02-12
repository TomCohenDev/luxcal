import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:io' show File, Directory;

// For web-only file download:
import 'dart:html' as html;

import 'package:LuxCal/src/models/user_model.dart'; // adjust the import as needed

Future<void> exportUserDataToExcel(List<UserModel> users) async {
  // Create a new Excel document.
  var excel = Excel.createExcel();
  // Create or get the sheet named "UserData".
  Sheet sheet = excel['UserData'];

  // Add a header row.
  sheet.appendRow([
    TextCellValue("Full Name"),
    TextCellValue("Nick Name"),
    TextCellValue("Phone Number"),
    TextCellValue("Email"),
  ]);

  // Add a row for each user.
  for (UserModel user in users) {
    sheet.appendRow([
      TextCellValue(user.fullName ?? ''),
      TextCellValue(user.nickName ?? ''),
      TextCellValue(user.phoneNumber ?? ''),
      TextCellValue(user.email ?? ''),
    ]);
  }

  // Encode the Excel file to bytes.
  List<int>? fileBytes = excel.encode();

  if (fileBytes == null) {
    print("Error encoding Excel file.");
    return;
  }

  // For web: trigger a file download.
  if (kIsWeb) {
    final blob = html.Blob([fileBytes],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "user_data.xlsx")
      ..click();
    html.Url.revokeObjectUrl(url);
  } else {
    // For mobile/desktop: Save the file to local storage.
    // You can choose getApplicationDocumentsDirectory() if you want a safe location.
    Directory directory = await getApplicationDocumentsDirectory();
    String outputFile = "${directory.path}/user_data.xlsx";
    File(outputFile)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    print("Excel file saved to $outputFile");

    // Optionally, you can now open or share the file using packages like `open_file` or `share_plus`.
  }
}
