// To parse this JSON data, do
//
//     final miniStatesList = miniStatesListFromJson(jsonString);

import 'dart:convert';

MiniStatesList miniStatesListFromJson(String str) => MiniStatesList.fromJson(json.decode(str));

String miniStatesListToJson(MiniStatesList data) => json.encode(data.toJson());

class MiniStatesList {
  int? count;
  List<MiniStatesData>? results;

  MiniStatesList({
    this.count,
    this.results,
  });

  factory MiniStatesList.fromJson(Map<String, dynamic> json) => MiniStatesList(
        count: json["count"],
        results: json["results"] == null ? [] : List<MiniStatesData>.from(json["results"]!.map((x) => MiniStatesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class MiniStatesData {
  String? id;
  String? name;

  MiniStatesData({
    this.id,
    this.name,
  });

  factory MiniStatesData.fromJson(Map<String, dynamic> json) => MiniStatesData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
