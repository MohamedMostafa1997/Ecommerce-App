import 'package:ecommerce_app/features/login/login_repo.dart';
import 'package:ecommerce_app/features/login/models/login_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginRepo _loginRepo = Get.find();

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

    final LoginRequest loginRequest = LoginRequest(username: username, password: password); 

    final Map<String, dynamic> result = await _loginRepo.loginAndCacheUser(
      loginRequest
    );

    isLoading.value = false;
    return result;
  }

  @override
  void onClose() {
    print('object');
    usernameController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}
