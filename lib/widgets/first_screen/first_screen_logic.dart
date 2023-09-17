import 'package:flutter/material.dart';
import 'package:luxcal_app/widgets/login/login_view.dart';

import '../route/route_widget.dart';

void navigateToLoginWidget(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
      (route) => false);
}
