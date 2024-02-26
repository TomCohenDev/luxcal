// Automatic FlutterFlow imports
import 'package:path/path.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';
import 'package:revampedai/aaacore/theme/typography.dart';
import 'package:revampedai/aaasrc/utils/screen_size.dart';

import '/backend/backend.dart';
import '../../../custom/flutter_flow_theme.dart';
import '../../../custom/flutter_flow_util.dart';
import '../../../custom/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({
    Key? key,
    this.width,
    this.height,
    this.onPressed,
    this.radios,
    this.textSize,
    this.gradient1 = const Color.fromARGB(255, 206, 94, 177),
    this.gradient2 = const Color.fromARGB(255, 250, 205, 116),
    this.textColor,
    this.isActive = true,
    this.padding,
    required this.buttonText,
  }) : super(key: key);

  double? padding;
  bool isActive;
  double? width;
  double? height;
  double? radios;
  double? textSize;
  Color gradient1;
  Color gradient2;
  Color? textColor;

  // final Future<dynamic> Function()? onPressed;
  final Function()? onPressed;

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: IgnorePointer(
        ignoring: !isActive,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radios ?? 30))),
          child: Ink(
            decoration: BoxDecoration(
                gradient: isActive
                    ? AppPalette.gradients.main
                    : AppPalette.gradients.dry,
                borderRadius: BorderRadius.circular(radios ?? 30)),
            child: Container(
              width: width ?? ScreenInfo(context).width * 0.85,
              height: height ?? 60,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
                child: Text(
                  buttonText,
                  style: AppTypography.mainButton,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
