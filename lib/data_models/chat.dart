///
/// Created by Auro on 09/12/22 at 9:04 PM
///

// To parse this JSON data, do
//
//     final chatDatum = chatDatumFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/user.dart';

ChatDatum chatDatumFromJson(String str) => ChatDatum.fromJson(json.decode(str));

String chatDatumToJson(ChatDatum data) => json.encode(data.toJson());

class ChatDatum {
  ChatDatum({
    this.id,
    this.createdBy,
    this.message,
    this.conversation,
    this.allowedUsers,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.attachment,
  });

  String? id;
  User? createdBy;
  String? message;
  String? conversation;
  Attachment? attachment;
  List<String>? allowedUsers;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ChatDatum.fromJson(Map<String, dynamic> json) => ChatDatum(
        id: json["_id"],
        createdBy: json["createdBy"] == null
            ? null
            : json["createdBy"] is String
                ? User(id: json["createdBy"])
                : User.fromJson(json["createdBy"]),
        attachment: json["attachment"] == null
            ? null
            : json["attachment"] is String
                ? Attachment(type: 1, link: '')
                : Attachment.fromJson(json["attachment"]),
        message: json["message"],
        conversation: json["conversation"],
        allowedUsers: List<String>.from(json["allowedUsers"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy!.toJson(),
        "message": message,
        "attachment": attachment,
        "conversation": conversation,
        "allowedUsers": List<dynamic>.from(allowedUsers!.map((x) => x)),
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Attachment {
  Attachment({
    this.type,
    this.link,
  });

  String? link;
  int? type;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        link: json["link"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "type": type,
      };
}
