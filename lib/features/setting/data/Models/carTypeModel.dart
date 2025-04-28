// To parse this JSON data, do
//
//     final carTypeModel = carTypeModelFromMap(jsonString);

import 'dart:convert';

CarTypeModel carTypeModelFromMap(String str) =>
    CarTypeModel.fromJson(json.decode(str));

String carTypeModelToMap(CarTypeModel data) => json.encode(data.toMap());

class CarTypeModel {
  String id;
  String carTypeName;

  CarTypeModel({
    required this.id,
    required this.carTypeName,
  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
        id: json["id"],
        carTypeName: json["carType_Name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "carType_Name": carTypeName,
      };
}
