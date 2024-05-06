// To parse this JSON data, do
//
//     final getProfileDetails = getProfileDetailsFromJson(jsonString);

import 'dart:convert';

GetProfileDetails getProfileDetailsFromJson(String str) => GetProfileDetails.fromJson(json.decode(str));

String getProfileDetailsToJson(GetProfileDetails data) => json.encode(data.toJson());

class GetProfileDetails {
  String? id;
  String? username;
  String? fullname;
  String? email;
  String? phone;
  List<Group>? groups;
  String? firstName;
  String? lastName;
  dynamic otp;
  int? gender;
  String? genderName;
  String? isEmailVerified;
  String? isPhoneVerified;
  bool? isActive;
  int? deviceAccess;
  dynamic address;
  List<Area>? location;
  List<Area>? area;
  List<Area>? city;
  List<Area>? zone;
  List<Area>? state;
  String? latitude;
  String? longitude;
  Distributor? distributor;
  dynamic superstockist;

  GetProfileDetails({
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.phone,
    this.groups,
    this.firstName,
    this.lastName,
    this.otp,
    this.gender,
    this.genderName,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.isActive,
    this.deviceAccess,
    this.address,
    this.location,
    this.area,
    this.city,
    this.zone,
    this.state,
    this.latitude,
    this.longitude,
    this.distributor,
    this.superstockist,
  });

  factory GetProfileDetails.fromJson(Map<String, dynamic> json) => GetProfileDetails(
        id: json["id"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        groups: json["groups"] == null ? [] : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        firstName: json["first_name"],
        lastName: json["last_name"],
        otp: json["otp"],
        gender: json["gender"],
        genderName: json["gender_name"],
        isEmailVerified: json["is_email_verified"],
        isPhoneVerified: json["is_phone_verified"],
        isActive: json["is_active"],
        deviceAccess: json["device_access"],
        address: json["address"],
        location: json["location"] == null ? [] : List<Area>.from(json["location"]!.map((x) => Area.fromJson(x))),
        area: json["area"] == null ? [] : List<Area>.from(json["area"]!.map((x) => Area.fromJson(x))),
        city: json["city"] == null ? [] : List<Area>.from(json["city"]!.map((x) => Area.fromJson(x))),
        zone: json["zone"] == null ? [] : List<Area>.from(json["zone"]!.map((x) => Area.fromJson(x))),
        state: json["state"] == null ? [] : List<Area>.from(json["state"]!.map((x) => Area.fromJson(x))),
        latitude: json["latitude"],
        longitude: json["longitude"],
        distributor: json["distributor"] == null ? null : Distributor.fromJson(json["distributor"]),
        superstockist: json["superstockist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "first_name": firstName,
        "last_name": lastName,
        "otp": otp,
        "gender": gender,
        "gender_name": genderName,
        "is_email_verified": isEmailVerified,
        "is_phone_verified": isPhoneVerified,
        "is_active": isActive,
        "device_access": deviceAccess,
        "address": address,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x.toJson())),
        "area": area == null ? [] : List<dynamic>.from(area!.map((x) => x.toJson())),
        "city": city == null ? [] : List<dynamic>.from(city!.map((x) => x.toJson())),
        "zone": zone == null ? [] : List<dynamic>.from(zone!.map((x) => x.toJson())),
        "state": state == null ? [] : List<dynamic>.from(state!.map((x) => x.toJson())),
        "latitude": latitude,
        "longitude": longitude,
        "distributor": distributor?.toJson(),
        "superstockist": superstockist,
      };
}

class Area {
  String? id;
  String? name;

  Area({
    this.id,
    this.name,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Distributor {
  String? id;
  String? username;
  String? fullname;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  List<Area>? location;

  Distributor({
    this.id,
    this.username,
    this.fullname,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.location,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
        id: json["id"],
        username: json["username"],
        fullname: json["fullname"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        location: json["location"] == null ? [] : List<Area>.from(json["location"]!.map((x) => Area.fromJson(x))),
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

class Group {
  int? id;
  String? name;

  Group({
    this.id,
    this.name,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
