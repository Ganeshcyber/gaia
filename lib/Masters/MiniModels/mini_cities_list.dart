// To parse this JSON data, do
//
//     final miniCitiesList = miniCitiesListFromJson(jsonString);

import 'dart:convert';

MiniCitiesList miniCitiesListFromJson(String str) => MiniCitiesList.fromJson(json.decode(str));

String miniCitiesListToJson(MiniCitiesList data) => json.encode(data.toJson());

class MiniCitiesList {
  int? count;
  List<MiniCitiesData>? results;

  MiniCitiesList({
    this.count,
    this.results,
  });

  factory MiniCitiesList.fromJson(Map<String, dynamic> json) => MiniCitiesList(
        count: json["count"],
        results: json["results"] == null ? [] : List<MiniCitiesData>.from(json["results"]!.map((x) => MiniCitiesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MiniCitiesData {
  String? id;
  String? name;

  MiniCitiesData({
    this.id,
    this.name,
  });

  factory MiniCitiesData.fromJson(Map<String, dynamic> json) => MiniCitiesData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
