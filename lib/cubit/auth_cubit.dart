import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/repository/auth_repo.dart';

class AuthCubit extends Cubit<String?> {
  AuthCubit() : super(null);

  var repo = AuthRepo();

  Future<void> validateEmail(String? email) async {
    try {
      final response = await repo.validateEmail(email);
      emit(response);
    } catch (e) {
      emit("Doğrulama hatası: $e");
    }
  }

  Future<void> validatePassword(String? password) async {
    try {
      final response = await repo.validatePassword(password);
      emit(response);
    } catch (e) {
      emit("Doğrulama hatası: $e");
    }
  }

  Future<void> validateName(String? name) async {
    try {
      final response = await repo.validateName(name);
      emit(response);
    } catch (e) {
      emit("Doğrulama hatası: $e");
    }
  }
}
