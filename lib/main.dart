import 'package:ecommerce_app/core/utils/route_names.dart';
import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/database/database.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/features/launch/launch_screen.dart';
import 'package:ecommerce_app/features/login/login_screen.dart';
import 'package:ecommerce_app/features/product_details/product_details_repo.dart';
import 'package:ecommerce_app/features/product_details/product_details_screen.dart';
import 'package:ecommerce_app/features/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

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
    return GetMaterialApp(
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.grey[500],
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.init,
      getPages: [
        GetPage(name: RouteNames.init, page: () => LaunchScreen()),
        GetPage(name: RouteNames.login, page: () => LoginScreen()),
        GetPage(
          name: RouteNames.products,
          page: () => ProductsScreen(cartRepo: cartRepo),
        ),
        GetPage(
          name: RouteNames.productDetails,
          page: () {
            ProductDetailsRepo productDetailsRepo = ProductDetailsRepo(
              database,
            );
            return ProductDetailsScreen(
              productDetailsRepo: productDetailsRepo,
              cartRepo: cartRepo,
            );
          },
        ),
        GetPage(
          name: RouteNames.cart,
          page: () => CartScreen(cartRepo: cartRepo),
        ),
        GetPage(
          name: RouteNames.checkOut,
          page: () {
            CartRepo cartRepo2 = CartRepo(database);
            return CheckoutScreen(cartRepo: cartRepo2);
          },
        ),
      ],
    );
  }
}
