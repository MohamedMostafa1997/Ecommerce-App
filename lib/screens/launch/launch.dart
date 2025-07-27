import 'package:ecommerce_app/screens/login/login_screen.dart';
import 'package:ecommerce_app/screens/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Launch extends StatelessWidget {
  const Launch({super.key});


  Future<bool> cheakLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false ;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cheakLoginStatus(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        }
        return snapshot.data! ?Products() : Login();
      });
  }
}

