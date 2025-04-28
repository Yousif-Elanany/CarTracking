import 'package:car_tracking/core/network_Local/cache_helper.dart';
import 'package:car_tracking/features/auth/data/Models/userModel.dart';
import 'package:car_tracking/features/auth/data/web_services/AuthApiService.dart';

class AuthRepository {
  final AuthApiService apiService;

  AuthRepository(this.apiService);

  Future<UserModel> login(String email, String password) async {
    try {
      final data = await apiService.login(email: email, password: password);
      final userToken = data['token'];
      final userRole = data['role'];
      CacheHelper.saveData(key: 'token', value: data['token']);
      CacheHelper.saveData(key: 'role', value: data['role']);
      return UserModel.fromJson(data);
    } catch (e) {
      rethrow; // دي مهمة، علشان الخطأ يوصل للـ Cubit
    }
  }
}
