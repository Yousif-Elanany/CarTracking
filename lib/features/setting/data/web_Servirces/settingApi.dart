import 'dart:io';

import 'package:car_tracking/core/network_Local/dio_Helper.dart';
import 'package:car_tracking/features/setting/data/Models/BranchModel.dart';
import 'package:car_tracking/features/setting/data/Models/carModel.dart';
import 'package:car_tracking/features/setting/data/Models/carStatus.dart';
import 'package:car_tracking/features/setting/data/Models/carTypeModel.dart';
import 'package:car_tracking/features/setting/data/Models/cityModel.dart';
import 'package:car_tracking/features/setting/data/Models/regionModel.dart';
import 'package:car_tracking/features/setting/data/Models/userModel.dart';
import 'package:dio/dio.dart';

class SettingsApiService {
  // Future<Map<String, dynamic>> getStatiscs() async {
  //   try {
  //     final response = await DioHelper.get(
  //       'CarType/Get-All-CarType',
  //     );
  //     print(response.data["data"]);
  //     return response.data["data"];
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
  //   } catch (e) {
  //     throw Exception('Unexpected error: $e');
  //   }
  // }
  /////////////////////////Type Block //////////////////////////////////////////////

  Future<List<CarTypeModel>> getCarTypes() async {
    try {
      final response = await DioHelper.get(
        'CarType/Get-All-CarType',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjBhMjRhNDYwLWVkOTUtNGJkMC04YWQxLTYxMTU0NTFlYWI1NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjMyOTgyNzh9.fT4wS_gq6KJWUO2ukRAmdNMMlPdcTWz-d8wP44uEgNE',
        },
      );

      final List<dynamic> data = response.data["data"];
      print(data);

      return data.map((item) => CarTypeModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'setting data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  /////////////////////////Type Block //////////////////////////////////////////////

  /////////////////////////Status Block //////////////////////////////////////////////
  Future<List<CarStatusModel>> getCarStatus() async {
    try {
      final response = await DioHelper.get(
        'CarStatus/Get-All-CarStatus',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjBhMjRhNDYwLWVkOTUtNGJkMC04YWQxLTYxMTU0NTFlYWI1NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjMyOTgyNzh9.fT4wS_gq6KJWUO2ukRAmdNMMlPdcTWz-d8wP44uEgNE',
        },
      );

      final List<dynamic> data = response.data["data"];
      print(data);

      return data.map((item) => CarStatusModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<String> addCarStatus(String statusName) async {
    try {
      final response = await DioHelper.post(
        'CarStatus/Add-CarStatus',
        data: {"carStatus_Name": statusName},
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

  // Future<String> addCarType(String statusName, File? imageFile) async {
  //   try {
  //     if (imageFile == null) {
  //       throw Exception('No image selected');
  //     }
  //
  //     var data = FormData.fromMap({
  //       'CarType_Img': await MultipartFile.fromFile(
  //         imageFile.path,
  //         filename: imageFile.path.split('/').last,
  //       ),
  //       'CarType_Name': statusName,
  //     });
  //
  //
  //     final response = await DioHelper.post(
  //       'CarType/Add-CarType',
  //       data: data,
  //       headers: {
  //         'Content-Type': 'multipart/form-data', // ✅ مهم جداً هنا
  //         'Authorization': 'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI5NTYwMjJ9.HGp7sWGN9mk_ZiQmL3x5fNzvV0YnOzZKCXsOPKjYfbE',
  //       },
  //     );
  //
  //     print(response.data);
  //
  //     final String message = response.data["message"];
  //     return message;
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
  //   } catch (e) {
  //     throw Exception('Unexpected error: $e');
  //   }
  // }

  Future<String> addCarType(String statusName, File imageFile) async {
    try {
      String filePath = imageFile.path;

      // تحقق من امتداد الصورة
      bool isValidExtension = filePath.toLowerCase().endsWith('.jpg') ||
          filePath.toLowerCase().endsWith('.jpeg') ||
          filePath.toLowerCase().endsWith('.png') ||
          filePath.toLowerCase().endsWith('.gif');

      if (!isValidExtension) {
        print("❌ Invalid image extension");
        throw Exception('Only JPEG, PNG, and GIF images are allowed.');
      }

      // تحقق من وجود الملف
      if (!await imageFile.exists()) {
        print("❌ Image file does not exist");
        throw Exception("Image file does not exist");
      }

      // var data = FormData.fromMap({
      //   'CarType_Img': await MultipartFile.fromFile(filePath),
      //   'CarType_Name': statusName,
      // });
        FormData data = FormData.fromMap({
     //   'CarType_Img': await MultipartFile.fromFile(filePath),
        'CarType_Name': statusName,

        "CarType_Img": (imageFile!=null)?await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ):"",
      });

      var response = await DioHelper.post(
        'CarType/Add-CarType',
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjBhMjRhNDYwLWVkOTUtNGJkMC04YWQxLTYxMTU0NTFlYWI1NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjMyOTgyNzh9.fT4wS_gq6KJWUO2ukRAmdNMMlPdcTWz-d8wP44uEgNE',
        },
        data: data,
      );

      if (response.statusCode == 200) {
        print('✅ Success: ${response.data}');
        return response.data['message'];
      } else {
        print('❌ Error: ${response.statusMessage}');
        throw Exception('Failed to add car type');
      }
    } catch (e) {
      print('❗ Exception: $e');
      throw Exception('Unexpected error: $e');
    }
  }

/////////////////////////Status Block //////////////////////////////////////////////

//////////////////////////////City Block //////////////////////////////////////////////
  Future<List<CityModel>> getCities() async {
    try {
      final response = await DioHelper.get(
        'City/Get-All-Cities',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI3OTQ2MTB9.52ZRr0ZSK2Hn1cWWd3qZzRkQjdVNlizAEMxSxaJle3c',
        },
      );

      final List<dynamic> data = response.data["data"];

      return data.map((item) => CityModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<String> addCity(String cityName, String cityCode) async {
    try {
      final response = await DioHelper.post(
        'City/Add-City',
        data: {"city_Name": cityName, "city_Code": cityCode},
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

//////////////////////////////City Block //////////////////////////////////////////////

//////////////////////////////Branch Block //////////////////////////////////////////////
  Future<List<BranchModel>> getBranches() async {
    try {
      final response = await DioHelper.get(
        'Branch/Get-All-Branchs',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI5NTYwMjJ9.HGp7sWGN9mk_ZiQmL3x5fNzvV0YnOzZKCXsOPKjYfbE',
        },
      );

      final List<dynamic> data = response.data["data"];
      print(data);

      return data.map((item) => BranchModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<String> addBranch(
    String branchName,
    int allowed_Space,
    double Lat,
    double long,
    String nameOFLocation,
    String cityId,
  ) async {
    try {
      final response = await DioHelper.post(
        'Branch/Add-Branch',
        data: {
          "branch_Name": branchName,
          "allowed_Space": allowed_Space,
          "lat": Lat,
          "long": long,
          "nameOfLocation": nameOFLocation,
          "city_Id": cityId
        },
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

//////////////////////////////Branch Block //////////////////////////////////////////////

//////////////////////////////Region Block //////////////////////////////////////////////

  Future<List<RegionModel>> getRegions() async {
    try {
      final response = await DioHelper.get(
        'Region/Get-All-Regions',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI3OTQ2MTB9.52ZRr0ZSK2Hn1cWWd3qZzRkQjdVNlizAEMxSxaJle3c',
        },
      );

      final List<dynamic> data = response.data["data"];

      return data.map((item) => RegionModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<CarModel>> getCars() async {
    try {
      final response = await DioHelper.get(
        'Car/Get-All-Cars',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI3OTQ2MTB9.52ZRr0ZSK2Hn1cWWd3qZzRkQjdVNlizAEMxSxaJle3c',
        },
      );

      final List<dynamic> data = response.data["data"];

      return data.map((item) => CarModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<String> addRegion(
    String regionName,
    String coordinates,
    String nameOfLocation,
    bool isAlert,
    int minStayCount,
    String cityId,
  ) async {
    try {
      final response = await DioHelper.post(
        'Region/Add-Region',
        data: {
          "region_Name": regionName,
          "coordinates": "LINESTRING($coordinates)",
          "nameOfLocation": nameOfLocation,
          "isAlert": isAlert,
          "colorCode": "#Cd8f8b",
          "minStayCount": minStayCount,
          "city_Id": cityId
        },
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
//////////////////////////////Region Block //////////////////////////////////////////////

//////////////////////////////User Block //////////////////////////////////////////////

  Future<List<UsersModel>> getUsers() async {
    try {
      final response = await DioHelper.get(
        'User/Get-All-Users',
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI3OTQ2MTB9.52ZRr0ZSK2Hn1cWWd3qZzRkQjdVNlizAEMxSxaJle3c',
        },
      );

      final List<dynamic> data = response.data;

      return data.map((item) => UsersModel.fromJson(item)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<String> adduser(
    String userName,
    String email,
    String phoneNumber,
    bool isActive,
    String password,
    List<String> roles,
    List<Map<String, String>> carList,
    List<Map<String, String>> branchList,
  ) async {
    try {
      final response = await DioHelper.post(
        'User/Add-User-With-Roles',
        data: {
          "userName": userName,
          "email": email,
          "phoneNumber": "+966$phoneNumber",
          "userSek": password,
          "userActivation": isActive,
          "roles": roles,
          "getAllCarDtos": carList,
          "getAllBranchsDto": branchList
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI5NTYwMjJ9.HGp7sWGN9mk_ZiQmL3x5fNzvV0YnOzZKCXsOPKjYfbE',
        },
      );

      final String message = response.data;
      print(message);

      return message;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'dashBoard data Failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<String> addCar(
    String carName,
    String carPlate,
    String carTypeId,
    bool carBranchId,
    String carStatusId,
    String note,
  ) async {
    try {
      final response = await DioHelper.post(
        'Car/Add-Car',
        data: {
          "carName": carName,
          "carPlate": carPlate,
          "carTypeId": carTypeId,
          "carBranchId": carTypeId,
          "carStatusId": carStatusId,
          "note": note
        },
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

  Future<String> deleteCity(
    String cityId,
  ) async {
    try {
      final response = await DioHelper.delete(
        'City/Delete-City',
        query: {"cityId": cityId},
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

  Future<String> deleteStatus(
    String carStatusId,
  ) async {
    try {
      final response = await DioHelper.delete(
        'CarStatus/Delete-CarStatus',
        query: {"carStatusId": carStatusId},
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

  Future<String> deleteRegion(
    String regionId,
  ) async {
    try {
      final response = await DioHelper.delete(
        'Region/Delete-Region',
        query: {"regionId": regionId},
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

  Future<String> deleteType(
    String carTypeId,
  ) async {
    try {
      final response = await DioHelper.delete(
        'CarType/Delete-CarType',
        query: {"carTypeId": carTypeId},
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

  Future<String> deleteUser(
    String UserId,
  ) async {
    try {
      final response = await DioHelper.delete(
        'User/Delete-User',
        query: {"UserId": UserId},
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImE5OWZkZWYxLWRhOTQtNGY1OS04ZDMyLWJlZTQ0MDUyZjNjZiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJhZG1pbiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQENhclRyYWNrZXIuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjI5NTYwMjJ9.HGp7sWGN9mk_ZiQmL3x5fNzvV0YnOzZKCXsOPKjYfbE',
        },
      );

      return response.data;
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

  Future<String> deleteBranch(
    String branchId,
  ) async {
    try {
      final response = await DioHelper.delete(
        'Branch/Delete-Branch',
        query: {"branchId": branchId},
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
}
