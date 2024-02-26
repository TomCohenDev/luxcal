import 'package:flutter/material.dart';
import 'package:revampedai/aaacore/theme/typography.dart';
import 'package:revampedai/aaasrc/ui/widgets/elevated_container_card.dart';

class ElevatedTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  ElevatedTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedContainerCard(
      height: 40,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(text, style: AppTypography.textButtonText),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
