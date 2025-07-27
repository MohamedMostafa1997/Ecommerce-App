import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/launch/launch.dart';
import 'package:ecommerce_app/screens/login/login_screen.dart';
import 'package:ecommerce_app/screens/product_details/product_details_screen.dart';
import 'package:ecommerce_app/screens/products/products_screen.dart';
import 'package:ecommerce_app/utils/route_names.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp( 
        theme:ThemeData(
          progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.grey[500]),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.init,
        routes: {
          RouteNames.init :(context)=> Launch(),
          RouteNames.login :(context)=>Login(),
          RouteNames.products :(context)=>Products(),
          RouteNames.productDetails :(context)=>ProductDetails(),
          RouteNames.cart:(context)=>Cart()
        },
        )
    );
}

