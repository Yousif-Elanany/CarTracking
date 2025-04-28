// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromJson(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  String token;
  String role;
  String expiry;

  UserModel({
    required this.token,
    required this.role,
    required this.expiry,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    token: json["token"],
    role: json["role"],
    expiry: json["expiry"],
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "role": role,
    "expiry": expiry,
  };
}
