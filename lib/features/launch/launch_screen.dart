import 'package:ecommerce_app/core/utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  Future<bool> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, RouteNames.products);
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.login);
      }
    }

    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
