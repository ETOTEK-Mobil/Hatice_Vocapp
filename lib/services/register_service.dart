import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vocabulary_app/model/register_model.dart';
import 'package:vocabulary_app/services/login_service.dart';
import 'package:vocabulary_app/services/routes/api_routes.dart';

class RegisterService {
  Future<void> register(RegisterModel registerModel) async {
    final response = await http.post(
      ApiRoutes.register.uri,
      body: registerModel.toJson(),
    );

    if (response.statusCode == 201) {
      final token = jsonDecode(response.body)['token'];
      await LoginService.setToken(token);
    } else {
      // Sunucudan gelen hatayı detaylı göster
      final error = jsonDecode(response.body);
      throw Exception("Sunucu hatası: ${error['message'] ?? response.statusCode}");
    }
  }
}
