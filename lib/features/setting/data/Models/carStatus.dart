// To parse this JSON data, do
//
//     final carStatusModel = carStatusModelFromMap(jsonString);

import 'dart:convert';

CarStatusModel carStatusModelFromMap(String str) => CarStatusModel.fromJson(json.decode(str));

String carStatusModelToMap(CarStatusModel data) => json.encode(data.toMap());

class CarStatusModel {
  String id;
  String carStatusName;

  CarStatusModel({
    required this.id,
    required this.carStatusName,
  });

  factory CarStatusModel.fromJson(Map<String, dynamic> json) => CarStatusModel(
    id: json["id"],
    carStatusName: json["carStatus_Name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "carStatus_Name": carStatusName,
  };
}
