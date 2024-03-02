import 'package:LuxCal/navigation/navigation_logic.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:flutter/material.dart';


import '../pages/profile/profile_appbar_widget.dart';
import '../pages/profile/profile_view.dart';
import '../utils/theme.dart';
import '../pages/home/home_appbar_widget.dart';
import '../pages/home/home_view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  bool finishStartAppSetup = false;
  final GlobalKey<ScaffoldState> navigationScaffoldKey =
      GlobalKey<ScaffoldState>();
  late bool isConnected;
  int activeIndex = 0;

  var isDialOpen = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      const HomeWidget(),
      const ProfileWidget(),
    ];
    final List<PreferredSizeWidget> appbars = [
      const HomeAppbarWidget(),
      const ProfileAppbarWidget(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
          extendBody: true,
          key: navigationScaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: appbars[activeIndex],
          backgroundColor: Colors.transparent,
          body: tabs[activeIndex],
          bottomNavigationBar: navBarWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: floatingActionButton()),
    );
  }

  Widget navBarWidget() {
    final iconList = <IconData>[
      Icons.home,
      Icons.person,
    ];
    return AnimatedBottomNavigationBar(
      iconSize: 30,
      icons: iconList,
      activeIndex: activeIndex,
      activeColor: AppColors.bannerColor,
      inactiveColor: Colors.grey,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => activeIndex = index),
    );
  }

  Widget floatingActionButton() {
    return SpeedDial(
      backgroundColor: AppColors.bannerColor,
      overlayColor: Colors.black,
      overlayOpacity: 0.6,
      icon: Icons.add,
      activeIcon: Icons.close,
      // spacing: 3,
      openCloseDial: isDialOpen,
      // childPadding: const EdgeInsets.all(5),
      spaceBetweenChildren: 10,

      children: [
        SpeedDialChild(
            child: const Icon(Icons.event),
            backgroundColor: AppColors.bannerLightColor,
            foregroundColor: Colors.white,
            label: 'Add Event',
            onTap: () {
              onAddEventPress(context);
            }),
        SpeedDialChild(
          child: const Icon(Icons.newspaper),
          backgroundColor: AppColors.bannerLightColor,
          foregroundColor: Colors.white,
          label: 'Add News',
          onTap: () {
            onAddNewsPress(context);
          },
        ),
      ],
    );
  }
}
