import 'package:flutter/material.dart';
import 'package:LuxCal/pages/login/login_view.dart';

import '../../widgets/route/route_widget.dart';

void navigateToLoginWidget(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginWidget(),
      ),
      (route) => false);
}
