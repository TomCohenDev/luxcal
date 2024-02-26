import 'dart:io';

import 'package:flutter/material.dart';
import 'package:revampedai/aaacore/theme/theme.dart';
import 'package:revampedai/aaasrc/ui/widgets/custom_appbar.dart';

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
      backgroundColor: backgroundColor ?? context.theme.colorScheme.background,
      appBar: appBar,
      body: body,
    );
  }
}
