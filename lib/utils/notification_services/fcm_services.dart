import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:platemate_user/data_models/notification_data.dart';


Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    RemoteNotification? notification = message.notification;
    print("THIS IS THE NOTIFICATION:: ${message.data}");
    // return InAppNotification.showNotification(
    //   title: notification?.title ?? 'Title',
    //   description: notification?.body ?? 'Description',
    //   // imageUrl: notificationData.user.avatar,
    //   data: notification!.body,
    // );
  } catch (e, s) {
    log('Notification StackTrace $e $s');
  }
}

void onNotificationTapped(NotificationData notification) {
  String type = notification.type!;
  switch (type) {

  }
}
