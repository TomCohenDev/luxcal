import 'package:LuxCal/core/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool? extendBodyBehindAppBar;

  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.backgroundColor,
    this.extendBodyBehindAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      backgroundColor: backgroundColor ?? context.theme.scaffoldBackgroundColor,
      appBar: appBar,
      body: body,
    );
  }
}
