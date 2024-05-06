// To parse this JSON data, do
//
//     final getRetailersDetails = getRetailersDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_areas_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_cities_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_locations_list.dart';
import 'package:vaama_dairy_mobile/Masters/MiniModels/mini_states_list.dart';

GetRetailersDetails getRetailersDetailsFromJson(String str) => GetRetailersDetails.fromJson(json.decode(str));

String getRetailersDetailsToJson(GetRetailersDetails data) => json.encode(data.toJson());

class GetRetailersDetails {
  String? id;
  String? code;
  String? username;
  String? fullname;
  String? email;
  String? phone;
  String? alternatePhone;
  String? firstName;
  String? lastName;
  dynamic otp;
  int? gender;
  String? genderName;
  String? gstNo;
  String? isEmailVerified;
  String? isPhoneVerified;
  bool? isActive;
  MiniLocationsData? location;
  String? latitude;
  String? longitude;
  DefaultIngAddress? defaultBillingAddress;
  DefaultIngAddress? defaultShippingAddress;
  bool? isShippingAsBilling;
  Salesagent? salesagent;
  dynamic distributor;

  GetRetailersDetails({
    this.id,
    this.code,
    this.username,
    this.fullname,
    this.email,
    this.phone,
    this.alternatePhone,
    this.firstName,
    this.lastName,
    this.otp,
    this.gender,
    this.genderName,
    this.gstNo,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.isActive,
    this.location,
    this.latitude,
    this.longitude,
    this.defaultBillingAddress,
    this.defaultShippingAddress,
    this.isShippingAsBilling,
    this.salesagent,
    this.distributor,
  });

  factory GetRetailersDetails.fromJson(Map<String, dynamic> json) => GetRetailersDetails(
        id: json["id"],
        code: json["code"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        alternatePhone: json["alternate_phone"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        otp: json["otp"],
        gender: json["gender"],
        genderName: json["gender_name"],
        gstNo: json["gst_no"],
        isEmailVerified: json["is_email_verified"],
        isPhoneVerified: json["is_phone_verified"],
        isActive: json["is_active"],
        location: json["location"] == null ? null : MiniLocationsData.fromJson(json["location"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        defaultBillingAddress: json["default_billing_address"] == null ? null : DefaultIngAddress.fromJson(json["default_billing_address"]),
        defaultShippingAddress: json["default_shipping_address"] == null ? null : DefaultIngAddress.fromJson(json["default_shipping_address"]),
        isShippingAsBilling: json["is_shipping_as_billing"],
        salesagent: json["salesagent"] == null ? null : Salesagent.fromJson(json["salesagent"]),
        distributor: json["distributor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "username": username,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "alternate_phone": alternatePhone,
        "first_name": firstName,
        "last_name": lastName,
        "otp": otp,
        "gender": gender,
        "gender_name": genderName,
        "gst_no": gstNo,
        "is_email_verified": isEmailVerified,
        "is_phone_verified": isPhoneVerified,
        "is_active": isActive,
        "location": location?.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "default_billing_address": defaultBillingAddress?.toJson(),
        "default_shipping_address": defaultShippingAddress?.toJson(),
        "is_shipping_as_billing": isShippingAsBilling,
        "salesagent": salesagent?.toJson(),
        "distributor": distributor,
      };
}

class DefaultIngAddress {
  String? id;
  String? code;
  dynamic name;
  String? phone;
  dynamic alternatePhone;
  String? dNo;
  MiniAreasData? area;
  MiniCitiesData? city;
  MiniStatesData? state;
  String? landmark;
  String? pincode;

  DefaultIngAddress({
    this.id,
    this.code,
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

  factory DefaultIngAddress.fromJson(Map<String, dynamic> json) => DefaultIngAddress(
        id: json["id"],
        code: json["code"],
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

class Salesagent {
  String? id;
  String? username;
  String? fullname;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<MiniLocationsData>? location;

  Salesagent({
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.location,
  });

  factory Salesagent.fromJson(Map<String, dynamic> json) => Salesagent(
        id: json["id"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        location: json["location"] == null ? [] : List<MiniLocationsData>.from(json["location"]!.map((x) => MiniLocationsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullname": fullname,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x.toJson())),
      };
}
