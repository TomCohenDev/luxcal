import 'package:calendar_view/calendar_view.dart';
import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../add_event/event.dart';

class CalendarModel extends CustomModel {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  int previewsYear = DateTime.now().year;
  List<CalendarEventData<Event>> events = [];

  void initState(BuildContext context) {
    
  }

  void dispose() {}

  /// Additional helper methods are added here.
}
