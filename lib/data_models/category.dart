///
/// Created by Auro on 29/04/23 at 10:15 PM
///

// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  String id;
  String name;
  String avatar;
  int status;

  Category({
    required this.id,
    required this.name,
    required this.avatar,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"] ?? '',
        avatar: json["avatar"] ?? '',
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "avatar": avatar,
        "status": status,
      };
}
