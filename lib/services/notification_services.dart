import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined permission');
      }
      AppSettings.openAppSettings();
    }
  }

  void initLocalNotifications(RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handelMsg(message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        if (Platform.isAndroid) {
          initLocalNotifications(message);
          showNotification(message);
        }
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification != null) {
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notification',
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              channel.id.toString(), channel.name.toString(),
              channelDescription: 'your channel description',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
              //largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              ticker: 'ticker');

      DarwinNotificationDetails darwinNotificationDetails =
          const DarwinNotificationDetails(
              presentAlert: true, presentBadge: true, presentSound: true);

      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);

      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title ?? 'No title',
          message.notification!.body ?? 'No body',
          notificationDetails);

      /*flutterLocalNotificationsPlugin.periodicallyShow(
          0,
          message.notification!.title ?? 'No title',
          message.notification!.body ?? 'No body',
          RepeatInterval.everyMinute,
          notificationDetails);*/
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void handelMsg(RemoteMessage message) {
    if (message.data['type'].toString().toLowerCase() == ''.toLowerCase()) {
      //TODO : Any Specific screen redirect code here
    } else {
      //TODO : Redirect Notification Screen or Home Screen
      //Get.offAll(const HomeViewScreen());
      //Get.to(() => const NotificationViewScreen());
    }
  }

  Future<void> setUpInterMsg(BuildContext context) async {
    //TODO : APP IS Terminated
    RemoteMessage? msg = await FirebaseMessaging.instance.getInitialMessage();
    if (msg != null) {
      if (context.mounted) handelMsg(msg);
    }

    //TODO : APP IS Background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handelMsg(event);
    });
  }
}
