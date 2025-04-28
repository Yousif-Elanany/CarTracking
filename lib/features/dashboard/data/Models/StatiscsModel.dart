// To parse this JSON data, do
//
//     final statiscsModel = statiscsModelFromMap(jsonString);

import 'dart:convert';

StatiscsModel statiscsModelFromMap(String str) => StatiscsModel.fromJson(json.decode(str));

String statiscsModelToMap(StatiscsModel data) => json.encode(data.toMap());

class StatiscsModel {
  int? usersCount;
  int? carsCount;
  int? branchesCount;
  int? citiesCount;
  int? regionsCount;

  StatiscsModel({
     this.usersCount,
     this.carsCount,
     this.branchesCount,
     this.citiesCount,
     this.regionsCount,
  });

  factory StatiscsModel.fromJson(Map<String, dynamic> json) => StatiscsModel(
    usersCount: json["usersCount"],
    carsCount: json["carsCount"],
    branchesCount: json["branchesCount"],
    citiesCount: json["citiesCount"],
    regionsCount: json["regionsCount"],
  );

  Map<String, dynamic> toMap() => {
    "usersCount": usersCount,
    "carsCount": carsCount,
    "branchesCount": branchesCount,
    "citiesCount": citiesCount,
    "regionsCount": regionsCount,
  };
}
