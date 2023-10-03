import 'package:LuxCal/navigation/navigation.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:LuxCal/utils/utils.dart';
import 'package:LuxCal/pages/first_screen/first_screen_page.dart';
import 'package:LuxCal/pages/home/home_view.dart';
import 'package:LuxCal/pages/login/login_page.dart';
import 'package:LuxCal/pages/nickname/nickname_page.dart';

import 'backend/auth/auth_util.dart';
import 'backend/auth/firebase_user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();

  late Stream<LoginFirebaseUser> userStream;
  LoginFirebaseUser? initialUser;
  final authUserSub = authenticatedUserStream.listen((_) {});
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userStream = loginFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    storage.writeIfNull('display_first_screen', true);
    _firebaseMessaging.subscribeToTopic('events');
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   // Handle the incoming message, e.g., by showing a notification
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.messengerKey,
        home: !storage.read('display_first_screen')
            ? (currentUser != null && currentUser!.loggedIn)
                ? NavigationWidget()
                : LoginWidget()
            : FirstScreenWidget(),
      ),
    );
  }
}
