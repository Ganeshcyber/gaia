// To parse this JSON data, do
//
//     final miniZonesList = miniZonesListFromJson(jsonString);

import 'dart:convert';

MiniZonesList miniZonesListFromJson(String str) => MiniZonesList.fromJson(json.decode(str));

String miniZonesListToJson(MiniZonesList data) => json.encode(data.toJson());

class MiniZonesList {
  int? count;
  List<MiniZonesData>? results;

  MiniZonesList({
    this.count,
    this.results,
  });

  factory MiniZonesList.fromJson(Map<String, dynamic> json) => MiniZonesList(
        count: json["count"],
        results: json["results"] == null ? [] : List<MiniZonesData>.from(json["results"]!.map((x) => MiniZonesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MiniZonesData {
  String? id;
  String? name;

  MiniZonesData({
    this.id,
    this.name,
  });

  factory MiniZonesData.fromJson(Map<String, dynamic> json) => MiniZonesData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
