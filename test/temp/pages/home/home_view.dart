import 'package:LuxCal/utils/theme.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, Key? key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200,
        width: 200,
        color: AppColors.bannerColor,
        child: Text(
          "Test colors 123",
          style: AppTypography.bannerTitle,
        ),
      ),
    );
  }
}
