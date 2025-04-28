// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:car_tracking/features/auth/data/Models/userModel.dart';
import 'package:car_tracking/features/setting/business_logic/setting_states.dart';
import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/carStatus.dart';
import 'package:car_tracking/features/setting/data/Models/carTypeModel.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/features/setting/data/Models/regionModel.dart';
import 'package:car_tracking/features/setting/data/Models/userModel.dart';
import 'package:car_tracking/features/setting/data/repos/settingsRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class settingCubit extends Cubit<settingState> {
  final SettingRepository settingrepository;

  List<CarTypeModel> carTypeList = [];
  List<CarStatusModel> carStatusList = [];
  List<BranchModel> branchesList = [];
  List<CityModel> citiesList = [];
  List<RegionModel> regionsList = [];
  List<UsersModel> usersList = [];

  settingCubit(this.settingrepository) : super(settingInitial());

  List<CarTypeModel> getCarTypes() {
    emit(carTypeLoading());
    try {
      settingrepository.getCarTypes().then((cars) {
        emit(carTypeSuccess(cars));
        carTypeList = cars;
      });
    } catch (e) {
      emit(carTypeFailure(e.toString()));
    }
    return carTypeList;
  }

  List<CarStatusModel> getCarStatus() {
    emit(carStatusLoading());
    try {
      settingrepository.getCarStatus().then((cars) {
        emit(carStatusSuccess(cars));
        carStatusList = cars;
      });
    } catch (e) {
      emit(carStatusFailure(e.toString()));
    }
    return carStatusList;
  }

  addCarStatus(String statusName) {
    emit(addCarStatusLoading());
    try {
      settingrepository.addCarStatus(statusName).then((cars) {
        emit(addCarStatusSuccess(cars));
      });
    } catch (e) {
      emit(addCarStatusFailure(e.toString()));
    }
  }

  addCarType(String statusName, File? imageFile) {
    emit(addCarTypeLoading());
    try {
      settingrepository.addCarType(statusName, imageFile).then((cars) {
        emit(addCarTypeSuccess(cars));
      });
    } catch (e) {
      emit(addCarTypeFailure(e.toString()));
    }
  }

  List<CityModel> getCities() {
    emit(GetCitiesLoading());
    try {
      settingrepository.getCities().then((cars) {
        emit(GetCitiesSuccess(cars));
        citiesList = cars;
      });
    } catch (e) {
      emit(GetCitiesFailure(e.toString()));
    }
    return citiesList;
  }

  addCity(String cityName, String cityCode) {
    emit(addCityLoading());
    try {
      settingrepository.addCity(cityName, cityCode).then((e) {
        emit(addCitySuccess(e));
      });
    } catch (e) {
      emit(addCityFailure(e.toString()));
    }
  }

  List<BranchModel> getBranches() {
    emit(GetBranchesLoading());
    try {
      settingrepository.getBranches().then((cars) {
        emit(GetBranchesSuccess(cars));
        getCities();
        branchesList = cars;
      });
    } catch (e) {
      emit(GetBranchesFailure(e.toString()));
    }
    return branchesList;
  }

  addBranch(
    String branchName,
    int allowed_Space,
    double lat,
    double long,
    String nameOFLocation,
    String cityId,
  ) {
    emit(addBranchLoading());
    try {
      settingrepository
          .addBranch(
              branchName, allowed_Space, lat, long, nameOFLocation, cityId)
          .then((cars) {
        emit(addBranchSuccess(cars));
        getCities();
      });
    } catch (e) {
      emit(addBranchFailure(e.toString()));
    }
  }

  List<RegionModel> getRegions() {
    emit(GetRegionsLoading());
    try {
      settingrepository.getRegions().then((cars) {
        emit(GetRegionsSuccess(cars));
        getCities();
        regionsList = cars;
      });
    } catch (e) {
      emit(GetRegionsFailure(e.toString()));
    }
    return regionsList;
  }

  List<UsersModel> getUsers() {
    emit(GetUsersLoading());
    try {
      settingrepository.getUsers().then((cars) {
        emit(GetUsersSuccess(cars));
        getCities();
        getBranches();
        usersList = cars;
      });
    } catch (e) {
      emit(GetUsersFailure(e.toString()));
    }
    return usersList;
  }

  addRegion(
    String regionName,
    String coordinates,
    String nameOfLocation,
    bool isAlert,
    int minStayCount,
    String cityId,
  ) {
    emit(AddRegionLoading());
    try {
      settingrepository
          .addRegion(regionName, coordinates, nameOfLocation, isAlert,
              minStayCount, cityId)
          .then((cars) {
        emit(AddRegionSuccess(cars));
        getCities();
      });
    } catch (e) {
      emit(AddRegionFailure(e.toString()));
    }
  }

  addUser(
    String userName,
    String email,
    String phoneNumber,
    bool isActive,
    String password,
    String carId,
    String branchId,
  ) {
    emit(AddUserLoading());
    try {
      settingrepository
          .adduser(
              userName, email, phoneNumber, isActive, password, carId, branchId)
          .then((cars) {
        emit(AddUserSuccess(cars));
        getCities();
      });
    } catch (e) {
      emit(AddUserFailure(e.toString()));
    }
  }
}
