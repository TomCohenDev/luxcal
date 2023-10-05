import 'package:firebase_messaging/firebase_messaging.dart';

class Notifications {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token:  $fCMToken");
    _firebaseMessaging.subscribeToTopic('events');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMassage);
  }
}

Future<void> handleBackgroundMassage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
}
