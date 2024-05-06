// To parse this JSON data, do
//
//     final miniAreasList = miniAreasListFromJson(jsonString);

import 'dart:convert';

MiniAreasList miniAreasListFromJson(String str) => MiniAreasList.fromJson(json.decode(str));

String miniAreasListToJson(MiniAreasList data) => json.encode(data.toJson());

class MiniAreasList {
  int? count;
  List<MiniAreasData>? results;

  MiniAreasList({
    this.count,
    this.results,
  });

  factory MiniAreasList.fromJson(Map<String, dynamic> json) => MiniAreasList(
        count: json["count"],
        results: json["results"] == null ? [] : List<MiniAreasData>.from(json["results"]!.map((x) => MiniAreasData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MiniAreasData {
  String? id;
  String? name;

  MiniAreasData({
    this.id,
    this.name,
  });

  factory MiniAreasData.fromJson(Map<String, dynamic> json) => MiniAreasData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
