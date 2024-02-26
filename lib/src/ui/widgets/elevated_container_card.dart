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
        color: Colors.white,
        boxShadow: [
          boxShaow ??
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(0, 7), // changes position of shadow
              ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
