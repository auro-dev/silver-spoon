///
/// Created by Auro on 09/12/22 at 8:57 PM

// To parse this JSON data, do
//
//     final conversation = conversationFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/chat.dart';

ConversationDatum conversationFromJson(String str) =>
    ConversationDatum.fromJson(json.decode(str));

String conversationToJson(ConversationDatum data) => json.encode(data.toJson());

class ConversationDatum {
  ConversationDatum({
    this.id,
    this.users,
    this.name,
    this.avatar,
    this.event,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.lastMessageUpdatedAt,
    this.v,
  });

  String? id;
  List<String>? users;
  String? name;
  String? avatar;
  String? event;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastMessageUpdatedAt;
  ChatDatum? lastMessage;
  int? v;

  factory ConversationDatum.fromJson(Map<String, dynamic> json) =>
      ConversationDatum(
        id: json["_id"],
        users: List<String>.from(json["users"].map((x) => x)),
        name: json["name"],
        avatar: json["avatar"],
        event: json["event"],
        status: json["status"],
        lastMessage: json["lastMessage"] == null
            ? null
            : json["lastMessage"] is String
                ? ChatDatum(id: json["lastMessage"])
                : ChatDatum.fromJson(json["lastMessage"]),
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).toLocal()
            : null,
        lastMessageUpdatedAt: json["lastMessageUpdatedAt"] != null
            ? DateTime.parse(json["lastMessageUpdatedAt"]).toLocal()
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "users": List<dynamic>.from(users!.map((x) => x)),
        "name": name,
        "avatar": avatar,
        "event": event,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
