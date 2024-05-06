// To parse this JSON data, do
//
//     final getRetailersList = getRetailersListFromJson(jsonString);

import 'dart:convert';

import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_areas_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_cities_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_locations_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_states_list.dart';

GetRetailersList getRetailersListFromJson(String str) => GetRetailersList.fromJson(json.decode(str));

String getRetailersListToJson(GetRetailersList data) => json.encode(data.toJson());

class GetRetailersList {
  int? count;
  List<GetRetailersData>? results;

  GetRetailersList({
    this.count,
    this.results,
  });

  factory GetRetailersList.fromJson(Map<String, dynamic> json) => GetRetailersList(
        count: json["count"],
        results: json["results"] == null ? [] : List<GetRetailersData>.from(json["results"]!.map((x) => GetRetailersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class GetRetailersData {
  String? id;
  String? fullname;
  String? phone;
  MiniLocationsData? location;
  Address? defaultBillingAddress;
  Address? defaultShippingAddress;
  User? salesagent;
  Distributor? distributor;

  GetRetailersData({
    this.id,
    this.fullname,
    this.phone,
    this.location,
    this.defaultBillingAddress,
    this.defaultShippingAddress,
    this.salesagent,
    this.distributor,
  });

  factory GetRetailersData.fromJson(Map<String, dynamic> json) => GetRetailersData(
        id: json["id"],
        fullname: json["fullname"],
        phone: json["phone"],
        location: json["location"] == null ? null : MiniLocationsData.fromJson(json["location"]),
        defaultBillingAddress: json["default_billing_address"] == null ? null : Address.fromJson(json["default_billing_address"]),
        defaultShippingAddress: json["default_shipping_address"] == null ? null : Address.fromJson(json["default_shipping_address"]),
        salesagent: json["salesagent"] == null ? null : User.fromJson(json["salesagent"]),
        distributor: json["distributor"] == null ? null : Distributor.fromJson(json["distributor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "phone": phone,
        "location": location?.toJson(),
        "default_billing_address": defaultBillingAddress?.toJson(),
        "default_shipping_address": defaultShippingAddress?.toJson(),
        "salesagent": salesagent?.toJson(),
        "distributor": distributor?.toJson(),
      };
}

class Address {
  String? id;
  String? code;
  User? retailer;
  dynamic name;
  String? phone;
  dynamic alternatePhone;
  String? dNo;
  MiniAreasData? area;
  MiniCitiesData? city;
  MiniStatesData? state;
  String? landmark;
  String? pincode;

  Address({
    this.id,
    this.code,
    this.retailer,
    this.name,
    this.phone,
    this.alternatePhone,
    this.dNo,
    this.area,
    this.city,
    this.state,
    this.landmark,
    this.pincode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        code: json["code"],
        retailer: json["retailer"] == null ? null : User.fromJson(json["retailer"]),
        name: json["name"],
        phone: json["phone"],
        alternatePhone: json["alternate_phone"],
        dNo: json["d_no"],
        area: json["area"] == null ? null : MiniAreasData.fromJson(json["area"]),
        city: json["city"] == null ? null : MiniCitiesData.fromJson(json["city"]),
        state: json["state"] == null ? null : MiniStatesData.fromJson(json["state"]),
        landmark: json["landmark"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "retailer": retailer?.toJson(),
        "name": name,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "d_no": dNo,
        "area": area?.toJson(),
        "city": city?.toJson(),
        "state": state?.toJson(),
        "landmark": landmark,
        "pincode": pincode,
      };
}

class User {
  String? id;
  String? firstName;
  String? phone;

  User({
    this.id,
    this.firstName,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "phone": phone,
      };
}

class Distributor {
  String? id;
  String? fullname;
  String? username;

  Distributor({
    this.id,
    this.fullname,
    this.username,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "username": username,
      };
}
