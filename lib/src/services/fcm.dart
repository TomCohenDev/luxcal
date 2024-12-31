import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  FCM() {
    // Initialize background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> getNotificationPermissions() async {
    NotificationSettings permission =
        await _firebaseMessaging.requestPermission(provisional: true);
    if (permission.authorizationStatus == AuthorizationStatus.authorized) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        _firebaseMessaging.subscribeToTopic('notifications');
      }
    }
  }

  Future<String?> getNotificationToken() async {
    await _firebaseMessaging.requestPermission();

    // Log permission requested for notifications

    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      return fcmToken;
    }
    // Log failure to retrieve token
    return null;
  }

  Future<String?> getAPNToken() async {
    await _firebaseMessaging.requestPermission();

    // Log permission requested for APNs

    final apnsToken = await _firebaseMessaging.getAPNSToken();
    if (apnsToken != null) {
      // Log successful APNs token retrieval

      return apnsToken;
    }
    // Log failure to retrieve APNs token
    return null;
  }
}
