import 'package:vocabulary_app/services/constants/api_constants.dart';

enum ApiRoutes { login, register, random }

extension ApiRoutesExtension on ApiRoutes {
  String get route {
    switch (this) {
      case ApiRoutes.login:
        return '/login';
      case ApiRoutes.register:
        return '/register';
      case ApiRoutes.random:
        return '/random';
    }
  }

  String get url {
    return '${ApiConstants.baseUrl}$route';
  }

  Uri get uri {
    return Uri.parse('${ApiConstants.baseUrl}$route');
  }
}
