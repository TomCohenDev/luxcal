import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';


// GoRouter configuration

final navigatorKey = GlobalKey<NavigatorState>();
final storage = GetStorage();

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  observers: [
    AnalyticsService().getAnalyticsObserver(),
  ],
  initialLocation:
      storage.read('wasIntroVideoDisplayed') ? '/splash' : '/intro',
  routes: [
    GoRoute(
      path: '/intro',
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => AuthScreen(),
    ),
    
  ],
);
