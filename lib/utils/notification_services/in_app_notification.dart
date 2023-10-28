import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platemate_user/data_models/notification_data.dart';
import 'fcm_services.dart';

const String channelId = 'my_unique_fcm_id';
const String channelName = 'Festa Notification';
const String channelDescription = 'Festa Notification Channel';
const String notificationTicker = 'ticker';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails? notificationAppLaunchDetails;

class InAppNotification {
  ///Configuration for flutter local notifications both android and ios
  static Future<void> configureInAppNotification(
      {bool reqAlert = true,
      bool reqBadge = true,
      bool reqSound = true}) async {
    await Firebase.initializeApp();

    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: reqAlert,
        requestBadgePermission: reqBadge,
        requestSoundPermission: reqSound,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          if (payload != null) onNotificationTapped(json.decode(payload));
        });
    final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: (payload) async {
      //   print(
      //       "notification tapped:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:$payload}");
      //   if (payload != null)
      //     onNotificationTapped(json.decode(payload.payload!));
      // },
      // onDidReceiveBackgroundNotificationResponse: (payload) async {
      //   print(
      //       "notification tapped:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:$payload}");
      //   if (payload != null)
      //     onNotificationTapped(json.decode(payload.payload!));
      // },
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((m) {
      print("onMessageOpenedApp :: ${m.data}");
      onNotificationTapped(NotificationData.fromJson(m.data));
    });
    // FirebaseMessaging.onBackgroundMessage((m) async {
    //   print("onBackgroundMessage :: $m");
    //   return backgroundMessageHandler(m);
    // });
    FirebaseMessaging.onMessage.listen((m) {
      print("onMessage :: $m");
      backgroundMessageHandler(m);
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(AndroidNotificationChannel(
          channelId,
          channelName,
          importance: Importance.high,
        ));
  }

  static Future<void> showNotification(
      {String title = 'Ausi Care',
      String description = 'New notification.',
      String imageUrl = 'http://via.placeholder.com/128x128/00FF00/000000',
      String? data}) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        styleInformation: DefaultStyleInformation(true, true),
        importance: Importance.max,
        priority: Priority.max,
        ticker: notificationTicker,
        playSound: true,
        enableVibration: true,
        enableLights: true,
        color: Colors.blue,
        ledColor: Colors.blue,
        visibility: NotificationVisibility.public,
        ledOnMs: 1000,
        ledOffMs: 500);

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    try {
      await flutterLocalNotificationsPlugin.show(
          title.hashCode, title, description, platformChannelSpecifics,
          payload: data);
    } catch (e, s) {
      log('Error showing $e $s');
    }
  }
}

///downloads and saves the network image
Future<String?> downloadAndSaveFile(String url, String fileName) async {
  final status = await Permission.storage.status;
  if (status.isGranted) {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      debugPrint('Download service done for : $url to $filePath.');
      return filePath;
    } else {
      debugPrint(
          'Download service received for : $url to $fileName but failed because of 404 url.');
      return null;
    }
  } else {
    debugPrint(
        'Download service received for : $url to $fileName but denied because of Storage permission.');
    return null;
  }
}
