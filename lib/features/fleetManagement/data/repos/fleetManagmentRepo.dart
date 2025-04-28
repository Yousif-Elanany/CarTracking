import 'package:car_tracking/features/dashboard/data/Models/StatiscsModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/fleetManagement/data/Models/carTripModel.dart';
import 'package:car_tracking/features/fleetManagement/data/web_services/fleetManagementApi.dart';

class fleetManagmentRepository {
  final fleetManagmentApiService apiService;

  fleetManagmentRepository(this.apiService);

  Future<List<CarTrackerModel>> getCarTrackers() async {
    try {
      final data = await apiService.getCarTrackers();
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<CarTrackerModel> getCarTrackerById(String carId) async {
    try {
      final data = await apiService.getCarTrackerById(carId);
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<carTripModel>> getCarTrip(
    String carId,
    String startDate,
    String endDate,
  ) async {
    try {
      final data = await apiService.getCarTrip(
        carId: carId,
        startDate: startDate,
        endDate: endDate,
      );
      print(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
