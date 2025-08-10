import 'package:ecommerce_app/models/data_base/database.dart';
import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/checkout/cheakout_screen.dart';
import 'package:ecommerce_app/screens/launch/launch.dart';
import 'package:ecommerce_app/screens/login/login_screen.dart';
import 'package:ecommerce_app/screens/product_details/product_details_repo.dart';
import 'package:ecommerce_app/screens/product_details/product_details_screen.dart';
import 'package:ecommerce_app/screens/products/products_screen.dart';
import 'package:ecommerce_app/utils/route_names.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ProductDatabase productDatabase =
      await $FloorProductDatabase.databaseBuilder('product.db').build();

  runApp(App(database: productDatabase));
}

class App extends StatelessWidget {
  final ProductDatabase database;
  const App({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    CartRepo cartRepo = CartRepo(database);
    return MaterialApp(
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.grey[500],
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.init,
      routes: {
        RouteNames.init: (context) => LaunchScreen(),
        RouteNames.login: (context) => LoginScreen(),
        RouteNames.products: (context) => ProductsScreen(),
        RouteNames.productDetails: (context) {
          ProductDetailsRepo productDetailsRepo = ProductDetailsRepo(database);
          return ProductDetailsScreen(productDetailsRepo: productDetailsRepo, cartRepo: cartRepo,);
        },
        RouteNames.cart: (context) => CartScreen(cartRepo: cartRepo),
        RouteNames.cheakOut: (context) => CheckoutScreen(cartRepo: cartRepo,),
      },
    );
  }
}
