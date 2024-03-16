import 'package:LuxCal/core/theme/pallette.dart';
import 'package:flutter/material.dart';

class ElevatedContainerCard extends StatelessWidget {
  Widget child;
  double? width;
  double? height;
  BoxShadow? boxShaow;
  ElevatedContainerCard(
      {super.key, required this.child, this.height, this.width, this.boxShaow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppPalette.jacarta,
        boxShadow: [
          boxShaow ??
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
