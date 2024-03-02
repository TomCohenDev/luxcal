import 'package:flutter/material.dart';
import 'package:LuxCal/widgets/custom/ring.dart';

import '../../utils/screen_sizes.dart';
import '../../utils/theme.dart';

class BannerWidget extends StatelessWidget {
  final String title;
  final Color backGroundColor;
  final Color ringColor;
  final double height;
  final bool showBackButton;



  const BannerWidget({super.key, 
    required this.title,
    required this.backGroundColor,
    required this.ringColor,
    required this.height,
    this.showBackButton = false,
  }) ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenInfo(context).screenHeight,
      width: ScreenInfo(context).screenWidth,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: height,
            width: ScreenInfo(context).screenWidth,
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(40))),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: const Alignment(1, 1),
                  child: CustomPaint(
                    painter: RingPainter(25, 60, AppColors.bannerLightColor),
                  ),
                ),
                Align(
                  alignment: const Alignment(-1, -1),
                  child: CustomPaint(
                    painter: RingPainter(25, 60, AppColors.bannerLightColor),
                  ),
                ),
                Align(
                    alignment: const Alignment(0, 0.15),
                    child: Text(title, style: AppTypography.bannerTitle)),
                showBackButton
                    ? Align(
                        alignment: const Alignment(-0.95, -0.2),
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                          ),
                        ))
                    : Container(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: ScreenInfo(context).screenHeight - height,
                width: ScreenInfo(context).screenWidth,
                color: AppColors.backgroundColor),
          )
        ],
      ),
    );
  }
}
