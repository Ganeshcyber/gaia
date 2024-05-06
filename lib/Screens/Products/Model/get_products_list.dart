// To parse this JSON data, do
//
//     final getProductsList = getProductsListFromJson(jsonString);

import 'dart:convert';

GetProductsList getProductsListFromJson(String str) => GetProductsList.fromJson(json.decode(str));

String getProductsListToJson(GetProductsList data) => json.encode(data.toJson());

class GetProductsList {
  int? count;
  List<GetProductsData>? results;

  GetProductsList({
    this.count,
    this.results,
  });

  factory GetProductsList.fromJson(Map<String, dynamic> json) => GetProductsList(
        count: json["count"],
        results: json["results"] == null ? [] : List<GetProductsData>.from(json["results"]!.map((x) => GetProductsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class GetProductsData {
  String? id;
  String? name;
  Category? category;
  String? image;
  String? price;
  String? displayUnits;
  Tax? tax;

  GetProductsData({
    this.id,
    this.name,
    this.category,
    this.image,
    this.price,
    this.displayUnits,
    this.tax,
  });

  factory GetProductsData.fromJson(Map<String, dynamic> json) => GetProductsData(
        id: json["id"],
        name: json["name"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        image: json["image"],
        price: json["price"],
        displayUnits: json["display_units"],
        tax: json["tax"] == null ? null : Tax.fromJson(json["tax"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category?.toJson(),
        "image": image,
        "price": price,
        "display_units": displayUnits,
        "tax": tax?.toJson(),
      };
}

class Category {
  String? id;
  String? name;
  String? image;

  Category({
    this.id,
    this.name,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}

class Tax {
  String? id;
  String? name;
  int? tax;

  Tax({
    this.id,
    this.name,
    this.tax,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        name: json["name"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tax": tax,
      };
}
