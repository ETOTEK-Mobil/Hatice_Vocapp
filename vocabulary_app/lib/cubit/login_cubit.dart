import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/repository/login_repo.dart';

class LoginCubit extends Cubit<void> {
  LoginCubit() : super(0);

  var repo = LoginRepo();

  Future<void> login(String email, String password) async {
    await repo.login(email, password);
  }

  Future<void> loggedIn() async {
    var response = await repo.loggedIn();
    emit(response);
  }

  Future<void> logout() async {
    var response = await repo.logout();
    emit(response);
  }
}
