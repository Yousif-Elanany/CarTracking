// To parse this JSON data, do
//
//     final cityModel = cityModelFromMap(jsonString);

import 'dart:convert';

CityModel cityModelFromMap(String str) => CityModel.fromJson(json.decode(str));

String cityModelToMap(CityModel data) => json.encode(data.toMap());

class CityModel {
  String id;
  String cityName;
  String cityCode;

  CityModel({
    required this.id,
    required this.cityName,
    required this.cityCode,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    cityName: json["city_Name"],
    cityCode: json["city_Code"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "city_Name": cityName,
    "city_Code": cityCode,
  };
}
