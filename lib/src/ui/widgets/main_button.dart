// Automatic FlutterFlow imports

import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({
    Key? key,
    this.width,
    this.height,
    this.onPressed,
    this.radios,
    this.textSize,
    this.textColor,
    this.color,
    this.padding,
    required this.buttonText,
  }) : super(key: key);

  double? padding;
  double? width;
  double? height;
  double? radios;
  double? textSize;
  Color? color;
  Color? textColor;
  final Function()? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radios ?? 30))),
        child: Ink(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(radios ?? 30)),
          child: Container(
            width: width ?? context.width * 0.85,
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
    );
  }
}
