import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabulary_app/services/routes/api_routes.dart';

class LoginService {
  static Future<void> setToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('token', token);
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      ApiRoutes.login.uri,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      await setToken(token);
      return token;
    } else {
      throw Exception('Yanlış şifre/email');
    }
  }

  Future<bool> loggedIn() async {
    final instance = await SharedPreferences.getInstance();
    return instance.containsKey('token');
  }

  Future<void> logout() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('token');
  }
}
