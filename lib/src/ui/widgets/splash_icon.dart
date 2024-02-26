import 'package:flutter/material.dart';
import 'package:revampedai/aaacore/theme/theme.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.background,
      child: Center(
        child: Image.asset(
          'assets/icon/revamped_logo3.png',
          width: MediaQuery.of(context).size.width * 0.8,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
