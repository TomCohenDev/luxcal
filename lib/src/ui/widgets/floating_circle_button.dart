import 'package:flutter/material.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';
import 'package:revampedai/aaacore/theme/theme.dart';

class FloatingCircleButton extends StatelessWidget {
  FloatingCircleButton(
      {super.key, this.onPressed, this.icon, this.size, this.inverted = false});

  void Function()? onPressed;
  IconData? icon;
  double? size;
  bool inverted;

  @override
  Widget build(BuildContext context) => Container(
        width: size ?? 56.0,
        height: size ?? 56.0,
        child: FittedBox(
          child: FloatingActionButton(
            heroTag: null,
            shape: CircleBorder(),
            elevation: 0,
            onPressed: onPressed,
            child: Container(
              width: size ?? 56.0,
              height: size ?? 56.0,
              decoration: BoxDecoration(
                gradient: inverted
                    ? AppPalette.gradients.white
                    : AppPalette.gradients.main,
                shape: BoxShape.circle,
              ),
              child: Icon(
                color: inverted
                    ? context.theme.colorScheme.primary
                    : context.theme.colorScheme.onPrimary,
                icon,
                size: 30,
              ),
            ),
          ),
        ),
      );
}
