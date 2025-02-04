import 'package:vocabulary_app/services/login_service.dart';
import 'package:vocabulary_app/cubit/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final loginService = LoginService();

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await loginService.login(email, password);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> loggedIn() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await loginService.loggedIn();
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await loginService.logout();
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()));
    }
  }
}
