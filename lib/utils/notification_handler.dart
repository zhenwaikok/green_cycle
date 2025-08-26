import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:green_cycle_fyp/model/remote_message_data_model/remote_message_data_model.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';

/// Notification from background will display on system tray by default.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHanlder(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Create AndroidNotificationChannels for notifications
const AndroidNotificationChannel _generalChannel = AndroidNotificationChannel(
  'general channel',
  'General',
  description: 'This is the general channel for notifications.',
  importance: Importance.max,
);

class NotificationHandler {
  // Singleton Instance
  static final NotificationHandler instance = NotificationHandler._internal();

  NotificationHandler._internal();

  // StreamControllers for deep links
  final StreamController<String> _deepLinkController =
      StreamController<String>.broadcast();

  // Expose the streams
  Stream<String> get deepLinkStream => _deepLinkController.stream;

  String? _token;
  String? get token => _token;

  Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();

    // Initialize local notifications
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_generalChannel);

    const initializationSettingsAndroid = AndroidInitializationSettings(
      'mipmap/ic_launcher',
    );
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _selectNotification,
    );

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageAction(initialMessage);
      debugPrint(
        'App opened from terminated state via notification: ${initialMessage.data}',
      );
    }

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
        'Notification clicked with app in background: ${message.data}',
      );
      _handleMessageAction(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Firebase onMessage: ${message.notification?.title}');
      _showNotifcation(message);
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHanlder);

    _token = await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      _token = newToken;
      updateTokenToServer();
      debugPrint('Firebase Messaging Token refreshed: $_token');
    });

    print('Firebase Messaging Token: $_token');
    updateTokenToServer();
  }

  void dispose() {
    _deepLinkController.close();
  }

  Future<void> _showNotifcation(RemoteMessage message) async {
    final androidChannel = _generalChannel;

    final notificationDetail = NotificationDetails(
      android: AndroidNotificationDetails(
        androidChannel.id,
        androidChannel.name,
        channelDescription: androidChannel.description,
        icon: 'mipmap/ic_launcher',
        importance: androidChannel.importance,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        threadIdentifier: message.threadId,
      ),
    );

    final data = RemoteMessageDataModel.fromJson(message.data);

    try {
      await flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title ?? 'Green Cycle',
        message.notification?.body ?? '-',
        notificationDetail,
        payload: data.deeplink,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void updateTokenToServer() {
    final userRepo = UserRepository(
      sharePreferenceHandler: SharedPreferenceHandler(),
      userServices: UserServices(),
    );

    if (!userRepo.isLoggedIn) return;

    userRepo.updateFcmToken();
  }

  void _selectNotification(NotificationResponse notificationResponse) {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      print('Notification payload (deeplink): $payload');
      _deepLinkController.add(payload);
    }
  }

  void _handleMessageAction(RemoteMessage message) {
    final data = RemoteMessageDataModel.fromJson(message.data);
    print('remote message data model: $data');
    if (data.deeplink != null) {
      _deepLinkController.add(data.deeplink!);
    }
  }
}
