// To parse this JSON data, do
//
//     final miniLocationsList = miniLocationsListFromJson(jsonString);

import 'dart:convert';

MiniLocationsList miniLocationsListFromJson(String str) => MiniLocationsList.fromJson(json.decode(str));

String miniLocationsListToJson(MiniLocationsList data) => json.encode(data.toJson());

class MiniLocationsList {
  int? count;
  List<MiniLocationsData>? results;

  MiniLocationsList({
    this.count,
    this.results,
  });

  factory MiniLocationsList.fromJson(Map<String, dynamic> json) => MiniLocationsList(
        count: json["count"],
        results: json["results"] == null ? [] : List<MiniLocationsData>.from(json["results"]!.map((x) => MiniLocationsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MiniLocationsData {
  String? id;
  String? name;

  MiniLocationsData({
    this.id,
    this.name,
  });

  factory MiniLocationsData.fromJson(Map<String, dynamic> json) => MiniLocationsData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
