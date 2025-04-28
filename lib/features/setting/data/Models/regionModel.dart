// To parse this JSON data, do
//
//     final regionModelModel = regionModelModelFromMap(jsonString);

import 'dart:convert';

RegionModel regionModelModelFromMap(String str) =>
    RegionModel.fromJson(json.decode(str));

String regionModelModelToMap(RegionModel data) =>
    json.encode(data.toMap());

class RegionModel {
  String id;
  String regionName;
  String coordinates;
  String nameOfLocation;
  String createdAt;
  String updatedAt;
  bool isAlert;
  String colorCode;
  int minStayCount;
  String cityName;
  String cityCode;

  RegionModel({
    required this.id,
    required this.regionName,
    required this.coordinates,
    required this.nameOfLocation,
    required this.createdAt,
    required this.updatedAt,
    required this.isAlert,
    required this.colorCode,
    required this.minStayCount,
    required this.cityName,
    required this.cityCode,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      RegionModel(
        id: json["id"],
        regionName: json["region_Name"],
        coordinates: json["coordinates"],
        nameOfLocation: json["nameOfLocation"],
        createdAt: json["createdAt"]??"",
        updatedAt: json["updatedAt"]??"",
        isAlert: json["isAlert"],
        colorCode: json["colorCode"],
        minStayCount: json["minStayCount"],
        cityName: json["city_Name"],
        cityCode: json["city_Code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "region_Name": regionName,
        "coordinates": coordinates,
        "nameOfLocation": nameOfLocation,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "isAlert": isAlert,
        "colorCode": colorCode,
        "minStayCount": minStayCount,
        "city_Name": cityName,
        "city_Code": cityCode,
      };
}
