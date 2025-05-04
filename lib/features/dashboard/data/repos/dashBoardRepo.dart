import 'package:car_tracking/features/dashboard/data/Models/StatiscsModel.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/dashboard/data/web_ervices/dashBoardApiServices.dart';

class DashboardRepository {
  final dashBoardApiService apiService;

  DashboardRepository(this.apiService);

  Future<StatiscsModel> getStatiscs() async {
    try {
      final data = await apiService.getStatiscs();

      print(data);
      return StatiscsModel.fromJson(data);
    } catch (e) {
      rethrow; // دي مهمة، علشان الخطأ يوصل للـ Cubit
    }
  }

  Future<List<CarTrackerModel>> getCarTrackers() async {
    try {
      final data = await apiService.getCarTrackers();
      print(data);
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
}
