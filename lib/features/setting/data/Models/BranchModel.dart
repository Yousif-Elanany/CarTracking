// To parse this JSON data, do
//
//     final branchModel = branchModelFromMap(jsonString);

import 'dart:convert';

BranchModel branchModelFromMap(String str) => BranchModel.fromJson(json.decode(str));

String branchModelToMap(BranchModel data) => json.encode(data.toMap());

class BranchModel {
  String id;
  String branchName;
  int allowedSpace;
  num lat;
  num long;
  String nameOfLocation;
  String cityName;

  BranchModel({
    required this.id,
    required this.branchName,
    required this.allowedSpace,
    required this.lat,
    required this.long,
    required this.nameOfLocation,
    required this.cityName,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["id"],
    branchName: json["branch_Name"],
    allowedSpace: json["allowed_Space"],
    lat: json["lat"],
    long: json["long"],
    nameOfLocation: json["nameOfLocation"],
    cityName: json["city_Name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "branch_Name": branchName,
    "allowed_Space": allowedSpace,
    "lat": lat,
    "long": long,
    "nameOfLocation": nameOfLocation,
    "city_Name": cityName,
  };
}
