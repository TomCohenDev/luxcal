// Automatic FlutterFlow imports
import 'package:revampedai/aaasrc/ui/widgets/main_button.dart';

import '/backend/backend.dart';
import '../../../custom/flutter_flow_theme.dart';
import '../../../custom/flutter_flow_util.dart';
import '../../../custom/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  DialogButton({
    Key? key,
    this.onPressed,
    this.isCancelButton = false,
    this.padding = 12,
    required this.buttonText,
  }) : super(key: key);

  bool isCancelButton;
  double padding;
  final Function()? onPressed;
  final String buttonText;
  final gradient = LinearGradient(
    colors: [
      const Color.fromARGB(255, 206, 94, 177),
      const Color.fromARGB(255, 250, 205, 116),
    ],
  );

  final gradientCancel = LinearGradient(
    colors: [
      Color.fromARGB(255, 103, 53, 242),
      Color.fromARGB(255, 103, 53, 242),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Ink(
          decoration: BoxDecoration(
              gradient: isCancelButton ? gradientCancel : gradient,
              borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 40,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
              child: Text(
                buttonText,
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
