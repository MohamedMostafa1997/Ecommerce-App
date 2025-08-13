import 'package:ecommerce_app/core/utils/route_names.dart';
import 'package:ecommerce_app/features/login/login_controller.dart';
import 'package:ecommerce_app/features/login/widgets/login_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back 👋",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              "Login to your account",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller.usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              obscureText: true,
            ),

            SizedBox(height: 20),

            Obx(
              () =>
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final Map<String, dynamic> result =
                                await controller.loginAndValidate();
                            if (context.mounted) {
                              if (result['success']) {
                                Navigator.popAndPushNamed(
                                  context,
                                  RouteNames.products,
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder:
                                      (_) => LoginErrorDialog(
                                        message: result['message'],
                                      ),
                                );
                              }
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
