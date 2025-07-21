import 'package:ecommerce_app/screens/login/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginRepo _loginService = LoginRepo();

  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;

  Future<Map<String, dynamic>> loginAndValidate() async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      return {"success": false, "message": "Please fill all fields"};
    }

    isLoading.value = true;
    errorMessage.value = "";

    final Map<String, dynamic> result = await _loginService.loginAndCacheUser(
      username,
      password,
    );

    isLoading.value = false;
    return (result);
  }
}
