// To parse this JSON data, do
//
//     final miniUnitsList = miniUnitsListFromJson(jsonString);

import 'dart:convert';

MiniUnitsList miniUnitsListFromJson(String str) => MiniUnitsList.fromJson(json.decode(str));

String miniUnitsListToJson(MiniUnitsList data) => json.encode(data.toJson());

class MiniUnitsList {
  int? count;
  List<MiniUnitsData>? results;

  MiniUnitsList({
    this.count,
    this.results,
  });

  factory MiniUnitsList.fromJson(Map<String, dynamic> json) => MiniUnitsList(
        count: json["count"],
        results: json["results"] == null ? [] : List<MiniUnitsData>.from(json["results"]!.map((x) => MiniUnitsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MiniUnitsData {
  String? id;
  String? name;
  String? units;

  MiniUnitsData({
    this.id,
    this.name,
    this.units,
  });

  factory MiniUnitsData.fromJson(Map<String, dynamic> json) => MiniUnitsData(
        id: json["id"],
        name: json["name"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "units": units,
      };
}
