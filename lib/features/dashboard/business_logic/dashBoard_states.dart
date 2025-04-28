import 'package:car_tracking/features/auth/data/Models/userModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/StatiscsModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';


abstract class dashBoardState {}
class dashBoardInitial extends dashBoardState {}


class dashBoardLoading extends dashBoardState {}


class dashBoardSuccess extends dashBoardState {
  final StatiscsModel model;
  dashBoardSuccess(this.model);
}

class dashBoardFailure extends dashBoardState {
  final String error;
  dashBoardFailure(this.error);
}

class carTrackerLoading extends dashBoardState {}


class carTrackerSuccess extends dashBoardState {
  final List<CarTrackerModel> model;
  carTrackerSuccess(this.model);
}

class carTrackerFailure extends dashBoardState {
  final String error;
  carTrackerFailure(this.error);
}
