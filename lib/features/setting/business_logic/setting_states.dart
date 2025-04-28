import 'package:car_tracking/features/auth/data/Models/userModel.dart';
import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/carStatus.dart';
import 'package:car_tracking/features/setting/data/Models/carTypeModel.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/features/setting/data/Models/regionModel.dart';
import 'package:car_tracking/features/setting/data/Models/userModel.dart';

abstract class settingState {}

class settingInitial extends settingState {}

class carTypeLoading extends settingState {}

class carTypeSuccess extends settingState {
  final List<CarTypeModel> model;
  carTypeSuccess(this.model);
}

class carTypeFailure extends settingState {
  final String error;
  carTypeFailure(this.error);
}

class carStatusLoading extends settingState {}

class carStatusSuccess extends settingState {
  final List<CarStatusModel> model;
  carStatusSuccess(this.model);
}

class carStatusFailure extends settingState {
  final String error;
  carStatusFailure(this.error);
}

class addCarStatusLoading extends settingState {}

class addCarStatusSuccess extends settingState {
  final String massege;
  addCarStatusSuccess(this.massege);
}

class addCarStatusFailure extends settingState {
  final String error;
  addCarStatusFailure(this.error);
}

class addCarTypeLoading extends settingState {}

class addCarTypeSuccess extends settingState {
  final String massege;
  addCarTypeSuccess(this.massege);
}

class addCarTypeFailure extends settingState {
  final String error;
  addCarTypeFailure(this.error);
}

class GetBranchesLoading extends settingState {}

class GetBranchesSuccess extends settingState {
  final List<BranchModel> model;
  GetBranchesSuccess(this.model);
}

class GetBranchesFailure extends settingState {
  final String error;
  GetBranchesFailure(this.error);
}

class GetCitiesLoading extends settingState {}

class GetCitiesSuccess extends settingState {
  final List<CityModel> model;
  GetCitiesSuccess(this.model);
}

class GetCitiesFailure extends settingState {
  final String error;
  GetCitiesFailure(this.error);
}

class addCityLoading extends settingState {}

class addCitySuccess extends settingState {
  final String massege;
  addCitySuccess(this.massege);
}

class addCityFailure extends settingState {
  final String error;
  addCityFailure(this.error);
}

class addBranchLoading extends settingState {}

class addBranchSuccess extends settingState {
  final String massege;
  addBranchSuccess(this.massege);
}

class addBranchFailure extends settingState {
  final String error;
  addBranchFailure(this.error);
}

class GetRegionsLoading extends settingState {}

class GetRegionsSuccess extends settingState {
  final List<RegionModel> model;
  GetRegionsSuccess(this.model);
}

class GetRegionsFailure extends settingState {
  final String error;
  GetRegionsFailure(this.error);
}

class GetUsersLoading extends settingState {}

class GetUsersSuccess extends settingState {
  final List<UsersModel> model;
  GetUsersSuccess(this.model);
}

class GetUsersFailure extends settingState {
  final String error;
  GetUsersFailure(this.error);
}

class AddUserLoading extends settingState {}

class AddUserSuccess extends settingState {
  final String massege;
  AddUserSuccess(this.massege);
}

class AddUserFailure extends settingState {
  final String error;
  AddUserFailure(this.error);
}

class AddRegionLoading extends settingState {}

class AddRegionSuccess extends settingState {
  final String massege;
  AddRegionSuccess(this.massege);
}

class AddRegionFailure extends settingState {
  final String error;
  AddRegionFailure(this.error);
}
