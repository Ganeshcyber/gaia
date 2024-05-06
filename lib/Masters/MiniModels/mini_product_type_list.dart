// To parse this JSON data, do
//
//     final miniProductTypeList = miniProductTypeListFromJson(jsonString);

import 'dart:convert';

MiniProductTypeList miniProductTypeListFromJson(String str) => MiniProductTypeList.fromJson(json.decode(str));

String miniProductTypeListToJson(MiniProductTypeList data) => json.encode(data.toJson());

class MiniProductTypeList {
  int? count;
  List<MiniProductTypeData>? results;

  MiniProductTypeList({
    this.count,
    this.results,
  });

  factory MiniProductTypeList.fromJson(Map<String, dynamic> json) => MiniProductTypeList(
        count: json["count"],
        results: json["results"] == null ? [] : List<MiniProductTypeData>.from(json["results"]!.map((x) => MiniProductTypeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MiniProductTypeData {
  String? id;
  String? name;

  MiniProductTypeData({
    this.id,
    this.name,
  });

  factory MiniProductTypeData.fromJson(Map<String, dynamic> json) => MiniProductTypeData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
