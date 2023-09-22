import 'package:flutter/material.dart';
import 'package:LuxCal/backend/auth/auth_util.dart';
import 'package:LuxCal/utils/utils.dart';
import 'package:LuxCal/pages/home/home_view.dart';



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
