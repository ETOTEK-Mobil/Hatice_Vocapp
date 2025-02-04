import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vocabulary_app/repository/login_repo.dart';
import 'package:vocabulary_app/services/routes/api_routes.dart';

class RegisterRepo {
  Future<void> register(String email, String password, String username) async {
    final response = await http.post(
      ApiRoutes.register.uri,
      body: {
        'email': email,
        'password': password,
        'username': username,
      },
    );

    if (response.statusCode == 201) {
      final token = jsonDecode(response.body)['token'];
      await LoginRepo.setToken(token);
    } else {
      // Sunucudan gelen hatayı detaylı göster
      final error = jsonDecode(response.body);
      throw Exception(
          "Sunucu hatası: ${error['message'] ?? response.statusCode}");
    }
  }
}
