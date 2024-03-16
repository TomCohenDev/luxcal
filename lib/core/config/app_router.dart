import 'package:LuxCal/src/ui/screens/auth_screen.dart';
import 'package:LuxCal/src/ui/screens/calendar_screen.dart';
import 'package:LuxCal/src/ui/screens/login_screen.dart';
import 'package:LuxCal/src/ui/screens/nickname_screen.dart';
import 'package:LuxCal/src/ui/screens/profile_screen.dart';
import 'package:LuxCal/src/ui/screens/register_screen.dart';
import 'package:LuxCal/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration

final navigatorKey = GlobalKey<NavigatorState>();
final storage = GetStorage();

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/nickname',
      builder: (context, state) => NicknameScreen(),
    ),
    GoRoute(
      path: '/calendar',
      builder: (context, state) => CalendarScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
  ],
);
