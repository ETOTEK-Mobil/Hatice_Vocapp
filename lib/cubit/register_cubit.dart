import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_app/model/register_model.dart';
import 'package:vocabulary_app/services/register_service.dart';

class RegisterCubit extends Cubit<void> {
  RegisterCubit() : super(());

  var service = RegisterService();

  Future<void> register(RegisterModel registerModel) async {
    await service.register(registerModel);
  }
}
