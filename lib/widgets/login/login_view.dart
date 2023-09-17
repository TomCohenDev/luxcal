import 'package:flutter/material.dart';
import 'package:luxcal_app/utils/theme.dart';

import '../../utils/screen_sizes.dart';
import '../custom/quarter_circle.dart';
import '../custom/ring.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenInfo(context).screenHeight,
        width: ScreenInfo(context).screenWidth,
        child: Column(children: [
          banner(
              "Luxcal",
              AppTheme.of(context).bannerColor,
              AppTheme.of(context).bannerLightColor,
              ScreenInfo(context).screenHeight * 0.15)
        ]),
      ),
    );
  }

  Widget banner(
      String title, Color backGroundColor, Color ringColor, double height) {
    return Container(
      height: height,
      width: ScreenInfo(context).screenWidth,
      decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: QuarterCircle(
              color: Colors.blue,
              position:
                  QuarterPosition.bottomLeft, // specify the quarter position
            ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   height: 100,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: AppTheme.of(context).bannerLightColor,
            //   ),
            //   child: Container(
            //     //  AppTheme.of(context).bannerColor,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: AppTheme.of(context).bannerColor,
            //     ),
            //   ),
            // )
            // CustomPaint(
            //   painter:
            //       RingPainter(20, 55, AppTheme.of(context).bannerLightColor),
            // ),
          )
        ],
      ),
    );
  }
}
