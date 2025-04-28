import 'package:car_tracking/features/auth/data/Models/userModel.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel response;
  AuthSuccess(this.response);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
