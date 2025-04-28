import 'dart:io';

import 'package:car_tracking/features/auth/data/Models/userModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/StatiscsModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/carStatus.dart';
import 'package:car_tracking/features/setting/data/Models/carTypeModel.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/features/setting/data/Models/regionModel.dart';
import 'package:car_tracking/features/setting/data/web_Servirces/settingApi.dart';

import '../Models/userModel.dart';

class SettingRepository {
  final SettingsApiService apiService;

  SettingRepository(this.apiService);

  Future<List<CarTypeModel>> getCarTypes() async {
    try {
      final data = await apiService.getCarTypes();
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CarStatusModel>> getCarStatus() async {
    try {
      final data = await apiService.getCarStatus();
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addCarStatus(String statusName) async {
    try {
      final data = await apiService.addCarStatus(statusName);
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  addCarType(String statusName, File? imageFile) async {
    try {
      final data = await apiService.addCarType(statusName, imageFile!);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CityModel>> getCities() async {
    try {
      final data = await apiService.getCities();
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addCity(String cityName, String cityCode) async {
    try {
      final data = await apiService.addCity(cityName, cityCode);
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BranchModel>> getBranches() async {
    try {
      final data = await apiService.getBranches();
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addBranch(
    String branchName,
    int allowed_Space,
    double lat,
    double long,
    String nameOFLocation,
    String cityId,
  ) async {
    try {
      final data = await apiService.addBranch(
        branchName,
        allowed_Space,
        lat,
        long,
        nameOFLocation,
        cityId,
      );
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RegionModel>> getRegions() async {
    try {
      final data = await apiService.getRegions();
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UsersModel>> getUsers() async {
    try {
      final data = await apiService.getUsers();
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addRegion(
    String regionName,
    String coordinates,
    String nameOfLocation,
    bool isAlert,
    int minStayCount,
    String cityId,
  ) async {
    try {
      final data = await apiService.addRegion(regionName, coordinates,
          nameOfLocation, isAlert, minStayCount, cityId);
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> adduser(
    String userName,
    String email,
    String phoneNumber,
    bool isActive,
    String password,
    String carId,
    String branchId,
  ) async {
    try {
      final data = await apiService.adduser(
          userName, email, phoneNumber, isActive, password, carId, branchId);
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
