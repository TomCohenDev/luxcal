import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
class NavBarWidget extends StatefulWidget {
  final Function(String) onUpdateCurrentPage;
  final String currentPage;
  const NavBarWidget({
    Key? key,
    required this.onUpdateCurrentPage,
    required this.currentPage,
  }) : super(key: key);

  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  final double navbarHeight = 80;
  AlignmentDirectional indicatorLine = AlignmentDirectional(0, 0);
  final TextEditingController feedbackController = TextEditingController();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.currentPage) {
      case "Home":
        break;

      case "Profile":
        break;
      default:
    }
    return Container();
  }
}
