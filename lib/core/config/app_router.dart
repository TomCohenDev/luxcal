import 'package:LuxCal/src/models/event_model.dart';
import 'package:LuxCal/src/models/news_model.dart';
import 'package:LuxCal/src/ui/screens/add_event_screen.dart';
import 'package:LuxCal/src/ui/screens/add_news_screen.dart';
import 'package:LuxCal/src/ui/screens/auth_screen.dart';
import 'package:LuxCal/src/ui/screens/calendar_screen.dart';
import 'package:LuxCal/src/ui/screens/event_gallery_screen.dart';
import 'package:LuxCal/src/ui/screens/login_screen.dart';
import 'package:LuxCal/src/ui/screens/nickname_screen.dart';
import 'package:LuxCal/src/ui/screens/profile_screen.dart';
import 'package:LuxCal/src/ui/screens/register_screen.dart';
import 'package:LuxCal/src/ui/screens/selected_event_screen.dart';
import 'package:LuxCal/src/ui/screens/selected_news_screen.dart';
import 'package:LuxCal/src/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

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
    GoRoute(
      path: '/addEvent',
      builder: (context, state) => AddEventScreen(),
    ),
    GoRoute(
      path: '/addNews',
      builder: (context, state) => AddNewsScreen(),
    ),
    GoRoute(
      path: '/selectedNews',
      builder: (context, state) =>
          SelectedNewsScreen(newsModel: state.extra as NewsModel),
    ),
    GoRoute(
      path: '/selectedEvent',
      builder: (context, state) =>
          SelectedEventScreen(eventModel: state.extra as EventModel),
    ),
    GoRoute(
      path: '/event/:eventId/gallery',
      builder: (context, state) {
        final eventId = state.pathParameters['eventId']!;
        final isMaker = state.uri.queryParameters['isMaker'] == 'true';

        print('Event ID: $eventId, Is Maker: $isMaker');
        return EventGalleryScreen(eventId: eventId, isMaker: isMaker);
      },
    ),
  ],
);
