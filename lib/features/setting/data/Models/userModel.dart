// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UsersModel userModelFromMap(String str) => UsersModel.fromJson(json.decode(str));

String userModelToMap(UsersModel data) => json.encode(data.toMap());

class UsersModel {
  String id;
  String userName;
  String email;
  String phoneNumber;
  bool userActivation;
  dynamic roles;
  dynamic lastLogin;

  UsersModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.userActivation,
    required this.roles,
    required this.lastLogin,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    userActivation: json["userActivation"],
    roles: json["roles"]??"",
    lastLogin: json["lastLogin"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "userName": userName,
    "email": email,
    "phoneNumber": phoneNumber,
    "userActivation": userActivation,
    "roles": roles,
    "lastLogin": lastLogin,
  };
}
