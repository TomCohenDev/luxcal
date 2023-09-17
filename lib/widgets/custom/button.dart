// Automatic FlutterFlow imports
import '../../utils/theme.dart';
import '/backend/backend.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  CustomMainButton({
    Key? key,
    this.width,
    this.height,
    this.onPressed,
    this.onDisabledPressed,
    this.radios,
    this.textSize,
    this.buttonColor = const Color(0xFF7d54cd),
    this.active = true,
    required this.buttonText,
  })  : theme = AppTheme.lightMode,
        typography = AppThemeTypography(AppTheme.lightMode);

  double? width;
  double? height;
  double? radios;
  double? textSize;
  Color buttonColor;
  final AppTheme theme;
  final AppThemeTypography typography;
  bool active;
  // final Future<dynamic> Function()? onPressed;
  final Function()? onPressed;
  final Function()? onDisabledPressed;

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: active ? onPressed : onDisabledPressed ?? () {},
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radios ?? 20))),
      child: Ink(
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(radios ?? 20)),
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Text(buttonText, style: typography.buttonText),
        ),
      ),
    );
  }
}
