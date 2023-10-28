///
/// Created by Auro on 17/04/23 at 9:02 PM
///

import 'dart:convert';

TastePreference tastePreferenceFromJson(String str) =>
    TastePreference.fromJson(json.decode(str));

String tastePreferenceToJson(TastePreference data) =>
    json.encode(data.toJson());

class TastePreference {
  TastePreference({
    this.id,
    this.dietContext,
    this.sweetTooth,
    this.oilLevel,
    this.spicyLevel,
    this.createdBy,
    this.status,
    this.cuisinePreferences,
  });

  String? id;
  int? dietContext;
  bool? sweetTooth;
  int? oilLevel;
  int? spicyLevel;
  String? createdBy;
  int? status;
  List<CuisinePreference>? cuisinePreferences;

  factory TastePreference.fromJson(Map<String, dynamic> json) =>
      TastePreference(
        id: json["_id"],
        dietContext: json["dietContext"],
        sweetTooth: json["sweetTooth"],
        oilLevel: json["oilLevel"],
        spicyLevel: json["spicyLevel"],
        createdBy: json["createdBy"],
        status: json["status"],
        cuisinePreferences: json["cuisinePreferences"] == null
            ? []
            : List<CuisinePreference>.from(json["cuisinePreferences"].map((x) =>
                x is String
                    ? CuisinePreference.fromJson({"_id": x})
                    : CuisinePreference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "dietContext": dietContext,
        "sweetTooth": sweetTooth,
        "oilLevel": oilLevel,
        "spicyLevel": spicyLevel,
        "createdBy": createdBy,
        "status": status,
        "cuisinePreferences": List<dynamic>.from((cuisinePreferences ?? [])
            .map((x) => x is String ? {"_id": x} : x.toJson())),
      };
}

class CuisinePreference {
  CuisinePreference({
    required this.id,
    required this.name,
    required this.status,
    required this.v,
  });

  String id;
  String name;
  int status;
  int v;

  factory CuisinePreference.fromJson(Map<String, dynamic> json) =>
      CuisinePreference(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "status": status,
        "__v": v,
      };
}
