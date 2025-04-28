import 'package:car_tracking/features/dashboard/data/Models/StatiscsModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/fleetManagement/business_logic/fleetManagment_states.dart';
import 'package:car_tracking/features/fleetManagement/data/Models/carTripModel.dart';
import 'package:car_tracking/features/fleetManagement/data/repos/fleetManagmentRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class fleetManagmentCubit extends Cubit<fleetManagmentState> {
  final fleetManagmentRepository fleetManagmentrepository;
  List<CarTrackerModel> carTrackerList = [];
  List<carTripModel> carTripList = [];

  CarTrackerModel? carModel = CarTrackerModel(
      id: "",
      carName: "",
      carPlate: "",
      carTypeId: "",
      carTypeName: "",
      carBranchId: "",
      carBranchName: "",
      carStatusId: "",
      carStatusName: "",
      numOfTracker: 0,
      note: "",
      isStopRequest: false,
      isStopCar: false,
      tracker: []);
  StatiscsModel statics = StatiscsModel();
  fleetManagmentCubit(this.fleetManagmentrepository)
      : super(fleetManagmentInitial());

  List<CarTrackerModel> getcarTrackers() {
    emit(carTrackerLoading());
    try {
      fleetManagmentrepository.getCarTrackers().then((cars) {
        emit(carTrackerSuccess(cars));
        this.carTrackerList = cars;
      });
    } catch (e) {
      emit(carTrackerFailure(e.toString()));
    }
    return carTrackerList;
  }

  CarTrackerModel? getcarTrackerById(String carId) {
    emit(carTrackerByIdLoading());
    try {
      fleetManagmentrepository.getCarTrackerById(carId).then((car) {
        emit(carTrackerByIdSuccess(car));
        this.carModel = car;
      });
    } catch (e) {
      emit(carTrackerByIdFailure(e.toString()));
    }
    return carModel;
  }

  List<carTripModel> getCarTrip(
    String carId,
    String startDate,
    String endDate,
  ) {
    emit(carTripLoading());
    try {
      fleetManagmentrepository
          .getCarTrip(carId, startDate, endDate)
          .then((car) {
        emit(carTripSuccess(car));
        this.carTripList = car;
      });
    } catch (e) {
      emit(carTrackerByIdFailure(e.toString()));
    }
    return carTripList;
  }
}
