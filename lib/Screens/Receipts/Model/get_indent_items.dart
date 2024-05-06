// To parse this JSON data, do
//
//     final getIndentItems = getIndentItemsFromJson(jsonString);

import 'dart:convert';

import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_units_list_model.dart';

GetIndentItemsDetails getIndentItemsFromJson(String str) => GetIndentItemsDetails.fromJson(json.decode(str));

String getIndentItemsToJson(GetIndentItemsDetails data) => json.encode(data.toJson());

class GetIndentItemsDetails {
  String? retailerId;
  double? totalAmount;
  int? noOfItems;
  List<IndentItemsList>? items;

  GetIndentItemsDetails({
    this.retailerId,
    this.totalAmount,
    this.noOfItems,
    this.items,
  });

  factory GetIndentItemsDetails.fromJson(Map<String, dynamic> json) => GetIndentItemsDetails(
        retailerId: json["retailer_id"],
        totalAmount: json["total_amount"],
        noOfItems: json["no_of_items"],
        items: json["items"] == null ? [] : List<IndentItemsList>.from(json["items"]!.map((x) => IndentItemsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "retailer_id": retailerId,
        "total_amount": totalAmount,
        "no_of_items": noOfItems,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class IndentItemsList {
  Product? productName;
  String? productType;
  double? price;
  MiniUnitsData? unit;
  double? totalQuantity;

  IndentItemsList({
    this.productName,
    this.productType,
    this.price,
    this.unit,
    this.totalQuantity,
  });

  factory IndentItemsList.fromJson(Map<String, dynamic> json) => IndentItemsList(
        productName: json["product_name"] == null ? null : Product.fromJson(json["product_name"]),
        productType: json["product_type"],
        price: json["price"],
        unit: json["unit"] == null ? null : MiniUnitsData.fromJson(json["unit"]),
        totalQuantity: json["total_quantity"],
      );

  Map<String, dynamic> toJson() => {
        // "product_name": productName?.toJson(),
        // "product_type": productType,
        // "price": price,
        // "unit": unit?.toJson(),
        // "total_quantity": totalQuantity,
        "product_id": productName!.id, "unit_id": unit!.id, "received_qty": totalQuantity.toString()
      };
}

class Product {
  String? id;
  String? name;
  String? category;
  dynamic image;

  Product({
    this.id,
    this.name,
    this.category,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "image": image,
      };
}
