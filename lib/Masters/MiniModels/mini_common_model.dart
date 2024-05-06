// To parse this JSON data, do
//
//     final miniCommonModel = miniCommonModelFromJson(jsonString);

import 'dart:convert';

List<MiniCommonModel> miniCommonModelFromJson(String str) => List<MiniCommonModel>.from(json.decode(str).map((x) => MiniCommonModel.fromJson(x)));

String miniCommonModelToJson(List<MiniCommonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MiniCommonModel {
  MiniCommonModel({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory MiniCommonModel.fromJson(Map<String, dynamic> json) => MiniCommonModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
