import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;

  static init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://mobilecartracking.uat.toq.sa/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 50),
        headers: {
          // احذف Content-Type هنا
          'Accept': 'application/json',
        },
      ),
    );
  }

  static Future<Response> get(
      String url, {
        Map<String, dynamic>? query,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? data,

      }) async {
    return await _dio.get(
      url,
      queryParameters: query,
      data: data,

      options: Options(headers: headers),
    );
  }

  static Future<Response> post(
      String url, {
        dynamic? data,
        Map<String, dynamic>? query,
        Map<String, dynamic>? headers,
      }) async {
    return await _dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response> put(
      String url, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? query,
        Map<String, dynamic>? headers,
      }) async {
    return await _dio.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete(
      String url, {
        Map<String, dynamic>? query,
        Map<String, dynamic>? data,
        Map<String, dynamic>? headers,
      }) async {
    return await _dio.delete(
      url,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }
}
