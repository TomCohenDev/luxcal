import 'package:flutter/material.dart';
import 'package:revampedai/aaasrc/utils/screen_size.dart';

class ElevatedGradientContainerCard extends StatelessWidget {
  Widget? child;
  double? width;
  double? height;

  ElevatedGradientContainerCard(
      {super.key, this.child, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ScreenInfo(context).width * 0.9),
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  spreadRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 206, 94, 177),
                  Color.fromARGB(255, 250, 205, 116),
                ],
              ),
            ),
            child: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: child),
          ),
        ),
      ),
    );
  }
}
