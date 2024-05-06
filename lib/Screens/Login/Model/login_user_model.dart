// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? id;
  dynamic email;
  String? phone;
  String? username;
  Tokens? tokens;
  String? fullName;
  String? groupName;
  bool? isDefaultPassword;

  LoginModel({
    this.id,
    this.email,
    this.phone,
    this.username,
    this.tokens,
    this.fullName,
    this.groupName,
    this.isDefaultPassword,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
        fullName: json["full_name"],
        groupName: json["group_name"],
        isDefaultPassword: json["is_default_password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "username": username,
        "tokens": tokens?.toJson(),
        "full_name": fullName,
        "group_name": groupName,
        "is_default_password": isDefaultPassword,
      };
}

class Tokens {
  String? refresh;
  String? access;

  Tokens({
    this.refresh,
    this.access,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
