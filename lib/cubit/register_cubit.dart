import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/repository/register_repo.dart';

class RegisterCubit extends Cubit<void> {
  RegisterCubit() : super(());

  var repo = RegisterRepo();

  Future<void> register(String username, String email, String password) async {
    await repo.register(email, password, username);
  }
}
