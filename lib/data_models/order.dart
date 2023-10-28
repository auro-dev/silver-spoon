///
/// Created by Auro on 30/04/23 at 9:06 AM
///

// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/restaurant.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String id;
  List<OrderedItem> orderedItems;
  String bookingId;
  Price price;
  int paymentStatus;
  DateTime placedOn;
  String table;
  Restaurant? restaurantDetails;
  String createdBy;
  String? notes;
  int status;
  List<dynamic> transactions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Order({
    required this.id,
    required this.orderedItems,
    required this.bookingId,
    required this.price,
    required this.paymentStatus,
    required this.placedOn,
    required this.table,
    this.restaurantDetails,
    required this.createdBy,
    required this.status,
    required this.transactions,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        orderedItems: List<OrderedItem>.from(
            json["orderedItems"].map((x) => OrderedItem.fromJson(x))),
        bookingId: json["bookingId"],
        price: Price.fromJson(json["price"]),
        paymentStatus: json["paymentStatus"],
        placedOn: DateTime.parse(json["placedOn"]),
        table: json["table"],
        restaurantDetails: json["restaurantDetails"] == null
            ? null
            : Restaurant.fromJson(
                json["restaurantDetails"] is String
                    ? {"_id": json["restaurantDetails"]}
                    : json["restaurantDetails"],
              ),
        createdBy: json["createdBy"],
        status: json["status"],
        notes: json["notes"] ?? '',
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderedItems": List<dynamic>.from(orderedItems.map((x) => x.toJson())),
        "bookingId": bookingId,
        "price": price.toJson(),
        "paymentStatus": paymentStatus,
        "placedOn": placedOn.toIso8601String(),
        "table": table,
        "notes": notes,
        "restaurantDetails":
            restaurantDetails == null ? null : restaurantDetails!.toJson(),
        "createdBy": createdBy,
        "status": status,
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class OrderedItem {
  MenuItem menuItem;
  int quantity;
  Variant variant;
  List<Customisation> customisations;
  String id;

  OrderedItem({
    required this.menuItem,
    required this.quantity,
    required this.variant,
    required this.customisations,
    required this.id,
  });

  factory OrderedItem.fromJson(Map<String, dynamic> json) => OrderedItem(
        menuItem: MenuItem.fromJson(json["menuItem"]),
        quantity: json["quantity"],
        variant: Variant.fromJson(json["variant"]),
        customisations: List<Customisation>.from(
            json["customisations"].map((x) => Customisation.fromJson(x))),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "menuItem": menuItem.toJson(),
        "quantity": quantity,
        "variant": variant.toJson(),
        "customisations":
            List<dynamic>.from(customisations.map((x) => x.toJson())),
        "_id": id,
      };
}

class Customisation {
  String title;
  int type;
  String? value;
  String id;
  List<String>? options;

  Customisation({
    required this.title,
    required this.type,
    this.value,
    required this.id,
    this.options,
  });

  factory Customisation.fromJson(Map<String, dynamic> json) => Customisation(
        title: json["title"],
        type: json["type"],
        value: json["value"],
        id: json["_id"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "value": value,
        "_id": id,
        "options": options,
      };
}
//
// class MenuItem {
//   String id;
//   String name;
//   String avatar;
//   String description;
//   int type;
//   List<Variant> variants;
//
//   // 1 - veg, 2- non veg
//   int dietContext;
//   String createdBy;
//   String menuItemCategory;
//   int status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;
//
//   MenuItem({
//     required this.id,
//     required this.name,
//     required this.avatar,
//     required this.description,
//     required this.type,
//     required this.variants,
//     required this.dietContext,
//     required this.createdBy,
//     required this.menuItemCategory,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });
//
//   factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
//         id: json["_id"],
//         name: json["name"],
//         avatar: json["avatar"],
//         description: json["description"],
//         type: json["type"],
//         variants: List<Variant>.from(
//             json["variants"].map((x) => Variant.fromJson(x))),
//         dietContext: json["dietContext"],
//         createdBy: json["createdBy"],
//         menuItemCategory: json["menuItemCategory"],
//         status: json["status"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "avatar": avatar,
//         "description": description,
//         "type": type,
//         "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
//         "dietContext": dietContext,
//         "createdBy": createdBy,
//         "menuItemCategory": menuItemCategory,
//         "status": status,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }
//
// class Variant {
//   String title;
//   int price;
//   String id;
//
//   Variant({
//     required this.title,
//     required this.price,
//     required this.id,
//   });
//
//   factory Variant.fromJson(Map<String, dynamic> json) => Variant(
//         title: json["title"],
//         price: json["price"],
//         id: json["_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "price": price,
//         "_id": id,
//       };
// }

class Price {
  double totalOriginalPrice;
  double totalSellingPrice;
  double tax;
  double discount;
  double finalPrice;

  Price({
    required this.totalOriginalPrice,
    required this.totalSellingPrice,
    required this.tax,
    required this.discount,
    required this.finalPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        totalOriginalPrice: json["totalOriginalPrice"] == null
            ? 0
            : json["totalOriginalPrice"].toDouble(),
        totalSellingPrice: json["totalSellingPrice"] == null
            ? 0
            : json["totalSellingPrice"].toDouble(),
        tax: json["tax"] == null ? 0 : json["tax"].toDouble(),
        discount: json["discount"] == null ? 0 : json["discount"].toDouble(),
        finalPrice:
            json["finalPrice"] == null ? 0 : json["finalPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "totalOriginalPrice": totalOriginalPrice,
        "totalSellingPrice": totalSellingPrice,
        "tax": tax,
        "discount": discount,
        "finalPrice": finalPrice,
      };
}
