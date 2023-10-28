///
/// Created by Auro on 17/04/23 at 9:21 PM
// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) =>
    NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) =>
    json.encode(data.toJson());

class NotificationData {
  NotificationData({
    this.id,
    this.message,
    this.status,
    this.title,
    this.entityType,
    this.entityId,
    this.type,
    this.user,
    this.icon,
    this.actionType,
    this.actionId,
    this.createdAt,
    this.unseenMessages,
    this.updatedAt,
  });

  String? id;
  String? message;
  String? status;
  String? title;
  String? entityType;
  String? entityId;
  String? type;
  String? user;
  String? icon;
  String? actionType;
  String? actionId;
  String? unseenMessages;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        id: json["_id"] ?? '',
        message: json["message"] ?? '',
        status: json["status"] != null ? json["status"].toString() : null,
        title: json["title"] ?? '',
        entityType: json["entityType"] ?? '',
        entityId: json["entityId"] ?? '',
        type: json["type"] != null ? json['type'].toString() : '',
        user: json["user"] ?? '',
        icon: json["icon"] ?? '',
        actionType: json["actionType"] ?? '',
        actionId: json["actionId"] ?? '',
        unseenMessages: json["unseenMessages"] ?? '',
        // unseenMessages: json["unseenMessages"] != null
        //     ? List<ChatDatum>.from(
        //         json["unseenMessages"].map((x) => ChatDatum.fromJson(x)))
        //     : [],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "status": status,
    "unseenMessages": unseenMessages,
    // "unseenMessages":
    //     List<dynamic>.from(unseenMessages!.map((x) => x.toJson())),
    "title": title,
    "entityType": entityType,
    "entityId": entityId,
    "type": type,
    "user": user,
    "icon": icon,
    "actionType": actionType,
    "actionId": actionId,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}
