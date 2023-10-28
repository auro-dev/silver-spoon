// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/taste_preference.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.accessToken,
    this.registrationToken,
    this.user,
  });

  String? accessToken;
  String? registrationToken;
  User? user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        accessToken: json["accessToken"],
        registrationToken: json["registrationToken"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "registrationToken": registrationToken,
        "user": user?.toJson(),
      };
}

class User {
  User(
      {required this.id,
      this.name,
      this.phone,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userDetails,
      this.newUserLogin,
      this.email,
      this.tastePreference,
      this.avatar});

  String id;
  String? name;
  String? phone;
  int? role;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserDetails? userDetails;
  bool? newUserLogin;
  String? email;
  String? avatar;
  TastePreference? tastePreference;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
        role: json["role"] ?? 1,
        status: json["status"] ?? 1,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).toLocal()
            : null,
        tastePreference: json["tastePreference"] == null
            ? null
            : TastePreference.fromJson(json["tastePreference"] is String
                ? {"_id": json["tastePreference"]}
                : json["tastePreference"]),
        newUserLogin: json["newUserLogin"] ?? false,
        email: json["email"] ?? '',
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "role": role,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "tastePreference":
            tastePreference == null ? null : tastePreference?.toJson(),
        "newUserLogin": newUserLogin,
        "email": email,
        'avatar': avatar
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class UserDetails {
  UserDetails(
      {required this.id,
      this.user,
      this.gender,
      this.dob,
      this.createdAt,
      this.updatedAt,
      this.height,
      this.weight,
      this.bloodGroup});

  String id;
  String? user;
  int? gender;
  DateTime? dob;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? height;
  double? weight;
  String? bloodGroup;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
      id: json["_id"],
      user: json["user"] ?? '',
      gender: json["gender"] ?? 0,
      dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"]).toLocal()
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"]).toLocal()
          : null,
      height: json["height"] ?? 0.0,
      weight: json["weight"] ?? 0.0,
      bloodGroup: json["bloodGroup"] ?? '');

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "gender": gender,
        "dob": dob?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "height": height,
        "weight": weight,
        "bloodGroup": bloodGroup
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetails &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
