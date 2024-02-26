import 'package:flutter/material.dart';
import 'package:revampedai/custom/flutter_flow_theme.dart';

class CustomBackButton extends StatelessWidget {
  void Function()? onTap;
  CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.9, 0.45),
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 20.0,
              ),
              Text(
                'Back',
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
