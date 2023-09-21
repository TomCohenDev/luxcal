import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LuxCal/utils/screen_sizes.dart';
import 'package:LuxCal/widgets/first_screen/first_screen_logic.dart';
import 'package:LuxCal/widgets/first_screen/first_screen_styles.dart';

import '../../utils/theme.dart';
import '../custom/ring.dart';

class FirstScreenWidget extends StatelessWidget {
  final AppTheme theme;
  final AppThemeTypography typography;
  FirstScreenWidget({super.key})
      : theme = AppTheme.lightMode,
        typography = AppThemeTypography(AppTheme.lightMode);
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          navigateToLoginWidget(context);
          storage.write('display_first_screen', false);
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: theme.bannerLightColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...backgroundRings(5, 50, 140, 60, theme.bannerColor),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ClipRect(
                        child: Image.asset("assets/images/face_image.png",
                            height: ScreenInfo(context).screenHeight * 0.22)),
                  ),
                  Flexible(child: Container()),
                  Text(
                    "Welcome To",
                    style: titleStyle_title,
                  ),
                  Text(
                    "LuxCal",
                    style: titleStyle_appname,
                  ),
                  Text(
                    "The extended Luxenberg & Arbisfeld \nFamily Nachas Calendar \n& Event Photo Album",
                    style: titleStyle_body,
                    textAlign: TextAlign.center,
                  ),
                  Flexible(child: Container()),
                  Text(
                    "Dedicated in loving memory to",
                    style: titleStyle_body,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Irwin Luxenberg, z'l",
                    style: titleStyle_bodyBold,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ז"ל',
                        style: titleStyle_bodyBold,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '  יצחק  יהודה  בן  אברהם',
                        style: titleStyle_bodyBold,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Flexible(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Click anywhere to continue",
                      style: titleStyle_body,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> backgroundRings(int ringCount, double ringThickness,
      double centerRadius, double padding, Color color) {
    List<Widget> rings = [];
    for (int i = 0; i < ringCount; i++) {
      double currentRadius = centerRadius + i * (ringThickness + padding);
      rings.add(
        Positioned.fill(
          child: CustomPaint(
            painter: RingPainter(ringThickness, currentRadius, color),
          ),
        ),
      );
    }
    return rings;
  }
}
