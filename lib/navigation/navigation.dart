import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import '../backend/auth/firebase_user_provider.dart';
import '../backend/auth/auth_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../dialogs/dialogs.dart';
import '../profile/profile_view.dart';
import '../utils/theme.dart';
import '../widgets/home/home_view.dart';
import 'navbar_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class NavigationWidget extends StatefulWidget {
  final AppTheme theme;
  final AppThemeTypography typography;
  NavigationWidget({super.key})
      : theme = AppTheme.lightMode,
        typography = AppThemeTypography(AppTheme.lightMode);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  bool finishStartAppSetup = false;
  final GlobalKey<ScaffoldState> navigationScaffoldKey =
      GlobalKey<ScaffoldState>();
  String _currentPageName = 'Home';
  late Widget? _currentPage;
  late bool isConnected;
  bool displayTutorialDialog = true;
  int activeIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.person,
  ];
  var customDialRoot = false;
  var isDialOpen = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();

    _checkAndHandleInternetConnectivity(); // Check and handle connectivity.

    // _currentPageName = widget.initialPage ?? _currentPageName;
    // _currentPage = widget.page;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    bool isConnected = await _checkInternetConnectivity();
    if (!isConnected) {
      networkErrorDialog(context, "startapp");
    }
  }

  // Add a method to check and handle internet connectivity.
  void _checkAndHandleInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // User is not connected to the internet.
    } else {
      // User is connected to the internet.
      if (_currentPageName == 'Home') {
        // Load background image only if the current page is 'Home'.
      }
    }

    // Listen to changes in connectivity status.
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        // User lost internet connection.
        await networkErrorDialog(context, "startapp");
      } else {
        // User regained internet connection.
        if (_currentPageName == 'Home') {}
      }
    });
  }

  Future<bool> _checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void _updateCurrentPage(String page) {
    setState(() {
      _currentPageName = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> tabs = {
      'Home': HomeWidget(),
      'Profile': ProfileWidget(),
    };
    // final Map<String, Widget> tabsAppBars = {
    //   'Home': HomeAppBar(),

    //   'Profile': ProfileAppBar(),
    // };

    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: navigationScaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.transparent,

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton: SpeedDial(
          backgroundColor: widget.theme.bannerColor,
          icon: Icons.add,
          activeIcon: Icons.close,
          // spacing: 3,
          openCloseDial: isDialOpen,
          // childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 10,
          dialRoot: customDialRoot
              ? (ctx, open, toggleChildren) {
                  return ElevatedButton(
                    onPressed: toggleChildren,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 18),
                    ),
                    child: const Text(
                      "Custom Dial Root",
                      style: TextStyle(fontSize: 17),
                    ),
                  );
                }
              : null,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.accessibility),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Add Event',
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              label: 'Add News',
              onTap: () {},
            ),
          ],
        ),
        body: tabs[_currentPageName]!,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: activeIndex,
          activeColor: Colors.blueGrey,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() => activeIndex = index),
          //other params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
