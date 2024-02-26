import 'dart:io';

import 'package:flutter/material.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';
import 'package:revampedai/aaacore/theme/theme.dart';
import 'package:revampedai/aaacore/theme/typography.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  List<Widget>? appBarWidgets;
  bool hide;

  CustomAppBar(
      {super.key, this.title = "", this.appBarWidgets, this.hide = true});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor:
            hide ? Colors.transparent : AppPalette.ultramarine_blue,
        automaticallyImplyLeading: false,
        leadingWidth: 75,
        flexibleSpace: Stack(
          children: [
            _title(context),
            ...appBarWidgets ?? [],
          ],
        ),
        elevation: 2.0,
      ),
    );
  }

  Widget _title(context) => Align(
        alignment: Alignment(0, 0.45),
        child: Text(
          title,
          style: AppTypography.appBarTitle,
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(
        hide
            ? 0
            : Platform.isIOS
                ? 40
                : 50,
      );
}
