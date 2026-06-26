import 'dart:io';

import 'package:carrefour/library/library.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:g_json/g_json.dart';

class MainConfig {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future setOrientationConfig() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  static Future<void> setStoreConfig() async {
    await UserStoreManager.shared.init();
    await DeviceStoreManager.shared.init();
    await _ensureAppToken();
  }

  static Future<void> _ensureAppToken() async {
    if (!DeviceStoreManager.shared.hasData(kAppToken)) {
      final token = const Uuid().v4();
      await DeviceStoreManager.shared.write(kAppToken, token);
    }
  }

  static setFirebaseConfig() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final data = JSON(message.data);
      if (DynamicRoute.shouldShowDialog(data)) {
        DynamicRoute.onForegroundNotifcation(data);
      } else {
        showForegroundMessage(message);
      }
      ClientManager.getNotificationCount();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      DynamicRoute.handleAction(JSON(message.data));
      ClientManager.getNotificationCount();
    });
  }

  static showForegroundMessage(RemoteMessage message) {
    Platform.isAndroid ? showAndroidMessage(message) : showIosMessage(message);
  }

  static showAndroidMessage(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    // final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: DynamicRoute.onNotification,
      onDidReceiveNotificationResponse: DynamicRoute.onNotification,
    );

    final notification = message.notification;
    final android = message.notification?.android;

    if (notification != null && android != null) {
      final jsonData = JSON(message.data);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonData.rawString(),
      );
    }
  }

  static showIosMessage(RemoteMessage message) async {
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: DynamicRoute.onNotification,
      onDidReceiveNotificationResponse: DynamicRoute.onNotification,
    );

    final notification = message.notification;
    const darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const platformDetails = NotificationDetails(
      iOS: darwinNotificationDetails,
    );

    if (notification != null) {
      final jsonData = JSON(message.data);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformDetails,
        payload: jsonData.rawString(),
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    MainConfig.showAndroidMessage(message);
  }
}
