///
/// Created by Auro on 30/04/23 at 7:02 AM
///

// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/category.dart';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  String id;
  String name;
  String avatar;
  String? description;
  Address address;
  List<double> coordinates;
  DateTime? openingTime;
  DateTime? closingTime;
  double averagePrice;
  double discountPercentage;
  bool crowded;
  int status;
  double? averageRating;
  int? totalRatings;
  double? distance;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String createdBy;
  List<MenuItem> menuItems;

  Restaurant({
    required this.id,
    required this.name,
    required this.avatar,
    this.description,
    required this.address,
    required this.coordinates,
    this.averageRating,
    this.totalRatings,
    this.distance,
    this.openingTime,
    this.closingTime,
    required this.averagePrice,
    required this.discountPercentage,
    required this.crowded,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.createdBy,
    required this.menuItems,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["_id"],
        name: json["name"],
        avatar: json["avatar"] ?? "",
        description: json["description"] ?? '',
        address: Address.fromJson(json["address"]),
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        openingTime: json["openingTime"] == null
            ? null
            : DateTime.parse(json["openingTime"]),
        closingTime: json["closingTime"] == null
            ? null
            : DateTime.parse(json["closingTime"]),
        averagePrice:
            json["averagePrice"] == null ? 0 : json["averagePrice"].toDouble(),
        averageRating: json["averageRating"] == null
            ? 0
            : json["averageRating"].toDouble(),
        totalRatings: json["totalRatings"] ?? 0,
        distance: json["distance"] == null ? 0 : json["distance"].toDouble(),
        discountPercentage: json["discountPercentage"] == null
            ? 0
            : json["discountPercentage"].toDouble(),
        crowded: json["crowded"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        createdBy: json["createdBy"],
        menuItems: json["menuItems"] == null
            ? []
            : List<MenuItem>.from(
                json["menuItems"].map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "avatar": avatar,
        "description": description,
        "address": address.toJson(),
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "openingTime":
            openingTime == null ? null : openingTime!.toIso8601String(),
        "closingTime":
            closingTime == null ? null : closingTime!.toIso8601String(),
        "averagePrice": averagePrice,
        "distance": distance,
        "averageRating": averageRating,
        "totalRatings": totalRatings,
        "discountPercentage": discountPercentage,
        "crowded": crowded,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "createdBy": createdBy,
        "menuItems": List<dynamic>.from(menuItems.map((x) => x.toJson())),
      };
}

class Address {
  String addressLine;
  String city;
  String state;
  String pinCode;
  String id;

  Address({
    required this.addressLine,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine: json["addressLine"],
        city: json["city"],
        state: json["state"],
        pinCode: json["pinCode"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine": addressLine,
        "city": city,
        "state": state,
        "pinCode": pinCode,
        "_id": id,
      };
}

class MenuItem {
  String id;
  String name;
  String avatar;
  String description;
  int type;
  List<Variant> variants;

  /// 1 - veg, 2- non veg
  int dietContext;
  String createdBy;
  Category? menuItemCategory;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MenuItem({
    required this.id,
    required this.name,
    required this.avatar,
    required this.description,
    required this.type,
    required this.variants,
    required this.dietContext,
    required this.createdBy,
    this.menuItemCategory,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json["_id"],
        name: json["name"],
        avatar: json["avatar"],
        description: json["description"],
        type: json["type"],
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
        dietContext: json["dietContext"],
        createdBy: json["createdBy"],
        menuItemCategory: json["menuItemCategory"] == null
            ? null
            : Category.fromJson(
                json["menuItemCategory"] is String
                    ? {"_id": json["menuItemCategory"]}
                    : json["menuItemCategory"],
              ),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "avatar": avatar,
        "description": description,
        "type": type,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "dietContext": dietContext,
        "createdBy": createdBy,
        "menuItemCategory":
            menuItemCategory == null ? null : menuItemCategory!.toJson(),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Variant {
  String title;
  int price;
  String id;

  Variant({
    required this.title,
    required this.price,
    required this.id,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        title: json["title"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "_id": id,
      };
}

class MenuItemCategorySection {
  String id;
  String name;
  List<MenuItem> menuItems;
  bool visible;

  MenuItemCategorySection({
    required this.id,
    required this.name,
    required this.menuItems,
    this.visible = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemCategorySection &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
