import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_functions/cloud_functions.dart';

class NotificationService {
  const NotificationService._();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'high_importance_channel',
    description: 'description',
    importance: Importance.max,
    playSound: true,
  );

  static NotificationDetails _notificationDetails() {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  static Future<void> initializeNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    await _notificationsPlugin.initialize(
      const InitializationSettings(
          android: androidInitializationSettings,
          iOS: DarwinInitializationSettings()),
    );
  }

  static void onMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    AppleNotification? appleNotification = message.notification?.apple;

    if (notification == null) return;

    if (androidNotification != null || appleNotification != null) {
      _notificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        _notificationDetails(),
      );
    }
  }

  /// function that send the notification to the tower with specific token
  static Future<bool> sendNotification(
      {required String title,
      required String body,
      required String? token}) async {
    try {
      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable("sendTowerNotification");
      final response =
          await callable.call(<String, dynamic>{'title': title, 'body': body});
      print("result is ${response.data ?? 'No data came back'}");
      if (response.data == null)
        return false;
      else {
        return true;
      }
    } catch (e) {
      print("there was an error $e");
      return false;
    }
  }

  static void onMessageOpenedApp(BuildContext context, RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    AppleNotification? appleNotification = message.notification?.apple;

    if (notification == null) return;

    if (androidNotification != null || appleNotification != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(notification.title ?? 'No Title'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.body ?? 'No body'),
              ],
            ),
          ),
        ),
      );
    }
  }
}
