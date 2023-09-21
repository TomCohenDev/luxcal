import 'package:flutter/material.dart';
import 'package:LuxCal/backend/auth/auth_util.dart';
import 'package:LuxCal/utils/utils.dart';
import 'package:LuxCal/widgets/home/home_view.dart';

String getColorString(String uncutString) {
  RegExp regExp = RegExp(r'Color\((0xff[0-9a-fA-F]{6})\)');
  Match? match = regExp.firstMatch(uncutString);

  if (match != null && match.groupCount > 0) {
    return match.group(1)!;
  } else {
    return '';
  }
}

void updateNickname(String nickname, String nicknameColor) {
  currentUserReference!.update({
    "nickname": nickname,
    "nickname_color": nicknameColor,
  });
}

void navigateToHomeWidget(context) {

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => HomeWidget(),
    ),
    (r) => false,
  );
}

bool isValidated(String? text1, String? text2) {


  if (text1 != null && text1 != "" && text2 != null || text2 != "") return true;
  Utils.showSnackBar(
      "Please make sure you have selected a Nickname and a Color");
  return false;
}
