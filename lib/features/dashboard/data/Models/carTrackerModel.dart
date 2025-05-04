// To parse this JSON data, do
//
//     final carTrackerModel = carTrackerModelFromMap(jsonString);

import 'dart:convert';

CarTrackerModel carTrackerModelFromMap(String str) =>
    CarTrackerModel.fromJson(json.decode(str));

String carTrackerModelToMap(CarTrackerModel data) => json.encode(data.toMap());

class CarTrackerModel {
  String id;
  String carName;
  String carPlate;
  String carTypeId;
  String carTypeName;
  String carBranchId;
  String carBranchName;
  String carStatusId;
  String carStatusName;
  int numOfTracker;
  String note;
  bool isStopRequest;
  bool isStopCar;
  List<Tracker> tracker;

  CarTrackerModel({
    required this.id,
    required this.carName,
    required this.carPlate,
    required this.carTypeId,
    required this.carTypeName,
    required this.carBranchId,
    required this.carBranchName,
    required this.carStatusId,
    required this.carStatusName,
    required this.numOfTracker,
    required this.note,
    required this.isStopRequest,
    required this.isStopCar,
    required this.tracker,
  });

  factory CarTrackerModel.fromJson(Map<String, dynamic> json) =>
      CarTrackerModel(
        id: json["id"] ?? "",
        carName: json["carName"] ?? "",
        carPlate: json["carPlate"] ?? "",
        carTypeId: json["carTypeId"] ?? "",
        carTypeName: json["carTypeName"] ?? "",
        carBranchId: json["carBranchId"] ?? "",
        carBranchName: json["carBranchName"] ?? "",
        carStatusId: json["carStatusId"] ?? "",
        carStatusName: json["carStatusName"] ?? "",
        numOfTracker: json["numOfTracker"] ?? 0,
        note: json["note"] ?? "",
        isStopRequest: json["isStopRequest"] ?? false,
        isStopCar: json["isStopCar"] ?? false,
        tracker:
            List<Tracker>.from(json["tracker"].map((x) => Tracker.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "carName": carName,
        "carPlate": carPlate,
        "carTypeId": carTypeId,
        "carTypeName": carTypeName,
        "carBranchId": carBranchId,
        "carBranchName": carBranchName,
        "carStatusId": carStatusId,
        "carStatusName": carStatusName,
        "numOfTracker": numOfTracker,
        "note": note,
        "isStopRequest": isStopRequest,
        "isStopCar": isStopCar,
        "tracker": List<dynamic>.from(tracker.map((x) => x.toMap())),
      };
}

class Tracker {
  String id;
  String imei;
  bool engineStatus;
  int carSpeed;
  bool isMoving;
  int sim;
  String updateTime;
  double lat;
  double long;
  String nameOfLocation;
  String serial;

  Tracker({
    required this.id,
    required this.imei,
    required this.engineStatus,
    required this.carSpeed,
    required this.isMoving,
    required this.sim,
    required this.updateTime,
    required this.lat,
    required this.long,
    required this.nameOfLocation,
    required this.serial,
  });

  factory Tracker.fromJson(Map<String, dynamic> json) => Tracker(
        id: json["id"],
        imei: json["imei"],
        engineStatus: json["engineStatus"] ?? false,
        carSpeed: json["car_Speed"] ?? 0,
        isMoving: json["isMoving"] ?? false,
        sim: json["sim"] ?? 0,
        updateTime: json["updateTime"] ?? "",
        lat: json["lat"]?.toDouble() ?? 0.0,
        long: json["long"]?.toDouble() ?? 0.0,
        nameOfLocation: json["nameOfLocation"] ?? "",
        serial: json["serial"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imei": imei,
        "engineStatus": engineStatus,
        "car_Speed": carSpeed,
        "isMoving": isMoving,
        "sim": sim,
        "updateTime": updateTime,
        "lat": lat,
        "long": long,
        "nameOfLocation": nameOfLocation,
        "serial": serial,
      };
}
