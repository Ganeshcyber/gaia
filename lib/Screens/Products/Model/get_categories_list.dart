// To parse this JSON data, do
//
//     final getCategoriesList = getCategoriesListFromJson(jsonString);

import 'dart:convert';

GetCategoriesList getCategoriesListFromJson(String str) => GetCategoriesList.fromJson(json.decode(str));

String getCategoriesListToJson(GetCategoriesList data) => json.encode(data.toJson());

class GetCategoriesList {
  int? count;
  List<GetCategoriesData>? results;

  GetCategoriesList({
    this.count,
    this.results,
  });

  factory GetCategoriesList.fromJson(Map<String, dynamic> json) => GetCategoriesList(
        count: json["count"],
        results: json["results"] == null ? [] : List<GetCategoriesData>.from(json["results"]!.map((x) => GetCategoriesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class GetCategoriesData {
  String? id;
  String? name;
  String? image;

  GetCategoriesData({
    this.id,
    this.name,
    this.image,
  });

  factory GetCategoriesData.fromJson(Map<String, dynamic> json) => GetCategoriesData(
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
