import 'dart:io';

import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/carModel.dart';
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
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CarStatusModel>> getCarStatus() async {
    try {
      final data = await apiService.getCarStatus();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addCarStatus(String statusName) async {
    try {
      final data = await apiService.addCarStatus(statusName);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  addCarType(String statusName, File? imageFile) async {
    try {
      final data = await apiService.addCarType(statusName, imageFile!);
      print(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CityModel>> getCities() async {
    try {
      final data = await apiService.getCities();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addCity(String cityName, String cityCode) async {
    try {
      final data = await apiService.addCity(cityName, cityCode);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BranchModel>> getBranches() async {
    try {
      final data = await apiService.getBranches();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addBranch(
    String branchName,
    int allowedSpace,
    double lat,
    double long,
    String nameOFLocation,
    String cityId,
  ) async {
    try {
      final data = await apiService.addBranch(
        branchName,
        allowedSpace,
        lat,
        long,
        nameOFLocation,
        cityId,
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RegionModel>> getRegions() async {
    try {
      final data = await apiService.getRegions();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CarModel>> getCars() async {
    try {
      final data = await apiService.getCars();
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UsersModel>> getUsers() async {
    try {
      final data = await apiService.getUsers();
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
    List<String> roles,
    List<Map<String, String>> carList,
    List<Map<String, String>> branchList,
  ) async {
    try {
      final data = await apiService.adduser(userName, email, phoneNumber,
          isActive, password, roles, carList, branchList);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addCar(String carName, String carPlate, String carTypeId,
      bool carBranchId, String carStatusId, String note) async {
    try {
      final data = await apiService.addCar(
          carName, carPlate, carTypeId, carBranchId, carStatusId, note);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteBranch(
    String branchId,
  ) async {
    try {
      final data = await apiService.deleteBranch(branchId);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteCar(
    String carId,
  ) async {
    try {
      final data = await apiService.deleteCar(carId);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteUser(
    String UserId,
  ) async {
    try {
      final data = await apiService.deleteUser(UserId);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteType(
    String carTypeId,
  ) async {
    try {
      final data = await apiService.deleteType(carTypeId);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteRegion(
    String regionId,
  ) async {
    try {
      final data = await apiService.deleteRegion(regionId);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteStatus(
    String carStatusId,
  ) async {
    try {
      final data = await apiService.deleteStatus(carStatusId);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> deleteCity(
    String cityId,
  ) async {
    try {
      final data = await apiService.deleteCity(cityId);
      return data;
    } catch (e) {
      rethrow;
    }
  }


  Future<String> editBranch(
      String branchId,

      String branchName,
      int allowedSpace,
      double lat,
      double long,
      String nameOFLocation,
      String cityId,
      ) async {
    try {
      final data = await apiService.editBranch(
        branchId,
        branchName,
        allowedSpace,
        lat,
        long,
        nameOFLocation,
        cityId,
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
