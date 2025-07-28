import 'package:ecommerce_app/models/data_base/database.dart';
import 'package:ecommerce_app/screens/cart/cart_screen.dart';
import 'package:ecommerce_app/screens/checkout/cheakout.dart';
import 'package:ecommerce_app/screens/launch/launch.dart';
import 'package:ecommerce_app/screens/login/login_screen.dart';
import 'package:ecommerce_app/screens/product_details/product_details_screen.dart';
import 'package:ecommerce_app/screens/products/products_screen.dart';
import 'package:ecommerce_app/utils/route_names.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ProductDatabase productDatabase =
      await $FloorProductDatabase.databaseBuilder('product.db').build();

  runApp(App(database:productDatabase ));
}

class App extends StatelessWidget {
  final ProductDatabase database;
  const App({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.grey[500],
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.init,
      routes: {
        RouteNames.init: (context) => Launch(),
        RouteNames.login: (context) => Login(),
        RouteNames.products: (context) => Products(),
        RouteNames.productDetails: (context) => ProductDetails(productId: product.id),
        RouteNames.cart: (context) => Cart(),
        RouteNames.cheakOut: (context) => Cheakout(),
      },
    );
  }
}
