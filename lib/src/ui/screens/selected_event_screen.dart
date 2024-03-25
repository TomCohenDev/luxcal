import 'package:LuxCal/src/models/event_model.dart';
import 'package:flutter/material.dart';

class SelectedEventScreen extends StatefulWidget {
  final EventModel eventModel;
  const SelectedEventScreen({super.key, required this.eventModel});

  @override
  State<SelectedEventScreen> createState() => _SelectedEventScreenState();
}

class _SelectedEventScreenState extends State<SelectedEventScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
