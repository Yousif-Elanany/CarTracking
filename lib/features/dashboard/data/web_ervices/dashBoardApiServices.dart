import 'package:car_tracking/core/network_Local/dio_Helper.dart';
import 'package:car_tracking/features/dashboard/data/Models/carTrackerModel.dart';
import 'package:dio/dio.dart';

class dashBoardApiService {
  Future<Map<String, dynamic>> getStatiscs() async {
    try {
      final response = await DioHelper.get(
        'Statiscs/Get-Statistics',
      );
print(response.data["data"]);
      return response.data["data"];
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  Future<String> deleteCar(
      String carId,
      ) async {
    try {
      final response = await DioHelper.delete(
        'Car/Delete-Car',
        query: {"carId": carId},
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
          'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI5NTYwMjJ9.HGp7sWGN9mk_ZiQmL3x5fNzvV0YnOzZKCXsOPKjYfbE',
        },
      );

      final String message = response.data["message"];

      return message;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  Future<List<CarTrackerModel>> getCarTrackers() async {
    try {
      final response = await DioHelper.get(
        'Car/Get-All-Cars-With-Trackers',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
          'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI3OTQ2MTB9.52ZRr0ZSK2Hn1cWWd3qZzRkQjdVNlizAEMxSxaJle3c',
        },
      );

      final List<dynamic> data = response.data;

      return data.map((item) => CarTrackerModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

}
