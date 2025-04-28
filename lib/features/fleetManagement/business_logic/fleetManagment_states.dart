
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/fleetManagement/data/Models/carTripModel.dart';

abstract class fleetManagmentState {}

class fleetManagmentInitial extends fleetManagmentState {}

class carTrackerLoading extends fleetManagmentState {}

class carTrackerSuccess extends fleetManagmentState {
  final List<CarTrackerModel> model;
  carTrackerSuccess(this.model);
}

class carTrackerFailure extends fleetManagmentState {
  final String error;
  carTrackerFailure(this.error);
}

class carTrackerByIdLoading extends fleetManagmentState {}

class carTrackerByIdSuccess extends fleetManagmentState {
  final CarTrackerModel model;
  carTrackerByIdSuccess(this.model);
}

class carTrackerByIdFailure extends fleetManagmentState {
  final String error;
  carTrackerByIdFailure(this.error);
}

class carTripLoading extends fleetManagmentState {}

class carTripSuccess extends fleetManagmentState {
  final List<carTripModel> tripListModel;
  carTripSuccess(this.tripListModel);
}

class carTripFailure extends fleetManagmentState {
  final String error;
  carTripFailure(this.error);
}
