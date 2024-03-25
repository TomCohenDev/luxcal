import 'package:LuxCal/src/models/news_model.dart';
import 'package:flutter/material.dart';

class SelectedNewsScreen extends StatefulWidget {
  final NewsModel newsModel;
  const SelectedNewsScreen({super.key, required this.newsModel});

  @override
  State<SelectedNewsScreen> createState() => _SelectedNewsScreenState();
}

class _SelectedNewsScreenState extends State<SelectedNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
