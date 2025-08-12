import 'package:ecommerce_app/core/utils/map_keys.dart';

class LoginRequest {
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {MapKeys.username: username, MapKeys.password: password};
  }
}
