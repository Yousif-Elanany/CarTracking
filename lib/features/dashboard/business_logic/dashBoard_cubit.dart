import 'package:car_tracking/features/dashboard/business_logic/dashBoard_states.dart';
import 'package:car_tracking/features/dashboard/data/Models/StatiscsModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/dashboard/data/repos/dashBoardRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class dashBoardCubit extends Cubit<dashBoardState> {
  final DashboardRepository dashboardrepository;
  StatiscsModel statics = StatiscsModel();
  List<CarTrackerModel> carTrackerList = [];
  dashBoardCubit(this.dashboardrepository) : super(dashBoardInitial());

  StatiscsModel getStatiscs() {
    emit(dashBoardLoading());
    try {
      dashboardrepository.getStatiscs().then((statics) {
        emit(dashBoardSuccess(statics));
        this.statics = statics;
      });
    } catch (e) {
      emit(dashBoardFailure(e.toString()));
    }
    return statics;
  }

  List<CarTrackerModel> getcarTrackers() {
    emit(carTrackerLoading());
    try {
      dashboardrepository.getCarTrackers().then((cars) {
        emit(carTrackerSuccess(cars));
        this.carTrackerList = cars;
      });
    } catch (e) {
      emit(carTrackerFailure(e.toString()));
    }
    return carTrackerList;
  }
}
