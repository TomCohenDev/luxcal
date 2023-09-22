import 'package:flutter/material.dart';

import '../../backend/auth/auth_util.dart';
import '../../utils/utils.dart';
import '../nickname/nickname_page.dart';

Future<void> signUp(context, _model) async {
  if (!Utils.isFormValidated(_model.formKey)) return;

  final user = await createAccountWithEmail(
    context,
    _model.emailTextController!.text,
    _model.passwordTextController!.text,
  );
  if (user == null) {
    return;
  }
  currentUserReference!
      .update({"display_name": _model.nameTextController!.text});

  navigateToNicknameWidget(context);
}

void navigateToNicknameWidget(context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => NicknameWidget(),
    ),
    (r) => false,
  );
}
