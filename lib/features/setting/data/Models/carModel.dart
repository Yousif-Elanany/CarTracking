// To parse this JSON data, do
//
//     final carModel = carModelFromMap(jsonString);

import 'dart:convert';

CarModel carModelFromMap(String str) => CarModel.fromJson(json.decode(str));

String carModelToMap(CarModel data) => json.encode(data.toMap());

class CarModel {
  String id;
  String name;

  CarModel({
    required this.id,
    required this.name,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
