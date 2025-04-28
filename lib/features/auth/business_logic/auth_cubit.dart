import 'package:car_tracking/features/auth/business_logic/auth_states.dart';
import 'package:car_tracking/features/auth/data/repos/authRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await repository.login(email, password);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
