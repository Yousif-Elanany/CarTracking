import 'package:car_tracking/core/network_Local/dio_Helper.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:car_tracking/features/fleetManagement/data/Models/carTripModel.dart';
import 'package:dio/dio.dart';

class fleetManagmentApiService {
  Future<List<CarTrackerModel>> getCarTrackers() async {
    try {
      final response = await DioHelper.get(
        'Car/Get-All-Cars-With-Trackers',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
          'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjBhMjRhNDYwLWVkOTUtNGJkMC04YWQxLTYxMTU0NTFlYWI1NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjMyOTgyNzh9.fT4wS_gq6KJWUO2ukRAmdNMMlPdcTWz-d8wP44uEgNE',
        },
      );

      final List<dynamic> data = response.data;
      print("data.length:${data.length}");
      return data.map((item) => CarTrackerModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<CarTrackerModel> getCarTrackerById(String carId) async {
    try {
      final response = await DioHelper.get(
        'Car/Get-Cars-By-Id',
        query: {"CarId": carId},
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjBhMjRhNDYwLWVkOTUtNGJkMC04YWQxLTYxMTU0NTFlYWI1NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjIzNTU3MTB9.pl785wxsxJzvTxyIF5SB01Y4B1QCKpdcwojFMY_5JGE',
        },
      );

      return CarTrackerModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<carTripModel>> getCarTrip({
    String? carId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await DioHelper.post(
        'Car/Get-Duration-Car-Trip',
        // query: {
        //   "CarId":carId
        // },
        data: {"carId": carId, "startDate": startDate, "endDate": endDate},
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjBhMjRhNDYwLWVkOTUtNGJkMC04YWQxLTYxMTU0NTFlYWI1NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjIzNTU3MTB9.pl785wxsxJzvTxyIF5SB01Y4B1QCKpdcwojFMY_5JGE',
        },
      );
      final List<dynamic> data = response.data;
      print("data.length:${data.length}");
      return data.map((item) => carTripModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
