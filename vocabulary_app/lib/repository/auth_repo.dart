import 'dart:core';

class AuthRepo {
  Future<String?> validateName(String? name) async {
    if (name == null || name.isEmpty) {
      return 'İsim alanı boş bırakılamaz';
    }
    if (name.length < 3) {
      return 'İsim alanı en az 3 karakter olmalıdır';
    }
    return null;
  }

  Future<String?> validateEmail(String? email) async {
    if (email == null || email.isEmpty) {
      return 'Email alanı boş bırakılamaz';
    }
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(email)) {
      return 'Geçerli bir email adresi giriniz';
    }
    return null;
  }

  Future<String?> validatePassword(String? password) async {
    if (password == null || password.isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    }
    if (password.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }
}
