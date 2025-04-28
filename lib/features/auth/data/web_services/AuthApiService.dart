import 'package:car_tracking/core/network_Local/dio_Helper.dart';
import 'package:dio/dio.dart';

class AuthApiService {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.post(
        'User/User-Login',
        data: {
          'email': email,
          'password': password,
        },
      );

      print(response.data["role"]);
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
