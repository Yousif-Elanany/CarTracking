// To parse this JSON data, do
//
//     final carTripModel = carTripModelFromMap(jsonString);

import 'dart:convert';

carTripModel carTripModelFromMap(String str) => carTripModel.fromJson(json.decode(str));

String carTripModelToMap(carTripModel data) => json.encode(data.toMap());

class carTripModel {
  int id;
  DateTime tripStart;
  DateTime tripEnd;
  bool isStop;

  carTripModel({
    required this.id,
    required this.tripStart,
    required this.tripEnd,
    required this.isStop,
  });

  factory carTripModel.fromJson(Map<String, dynamic> json) => carTripModel(
    id: json["id"],
    tripStart: DateTime.parse(json["tripStart"]),
    tripEnd: DateTime.parse(json["tripEnd"]),
    isStop: json["isStop"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "tripStart": tripStart.toIso8601String(),
    "tripEnd": tripEnd.toIso8601String(),
    "isStop": isStop,
  };
}
