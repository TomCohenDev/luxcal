import 'package:LuxCal/pages/add_event/add_event_page.dart';
import 'package:flutter/material.dart';

import '../pages/add_news/add_news_page.dart';

void onAddEventPress(context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventPage(),
      ));
}

void onAddNewsPress(context) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewsPage(),
      ));
}
