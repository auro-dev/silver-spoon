///
/// Created by Auro on 02/05/23 at 9:05 PM
///

import 'dart:convert';

import 'package:platemate_user/data_models/order.dart';

MenuCustomisation menuCustomisationFromJson(String str) =>
    MenuCustomisation.fromJson(json.decode(str));

String menuCustomisationToJson(MenuCustomisation data) =>
    json.encode(data.toJson());

class MenuCustomisation {
  String id;
  String menuItem;
  Customisation customisation;
  String createdBy;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MenuCustomisation({
    required this.id,
    required this.menuItem,
    required this.customisation,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MenuCustomisation.fromJson(Map<String, dynamic> json) =>
      MenuCustomisation(
        id: json["_id"],
        menuItem: json["menuItem"],
        customisation: Customisation.fromJson(json["customisation"]),
        createdBy: json["createdBy"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "menuItem": menuItem,
        "customisation": customisation.toJson(),
        "createdBy": createdBy,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
