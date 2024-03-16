// Automatic FlutterFlow imports
import '../../utils/theme.dart';
import '/backend/backend.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  CustomMainButton({super.key, 
    Key? key,
    this.width,
    this.height,
    this.onPressed,
    this.onDisabledPressed,
    this.radios,
    this.textSize,
    this.buttonColor = const Color(0xFF7d54cd),
    this.buttonTextColor = Colors.white,
    this.active = true,
    required this.buttonText,
  });

  double? width;
  double? height;
  double? radios;
  double? textSize;
  Color buttonColor;
  Color buttonTextColor;

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
          child: Text(
            buttonText,
            style: AppTypography.buttonText.copyWith(color: buttonTextColor),
          ),
        ),
      ),
    );
  }
}
