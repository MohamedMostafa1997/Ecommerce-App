import 'package:ecommerce_app/core/dependency_injection/dependency_injection.dart';
import 'package:ecommerce_app/core/utils/route_names.dart';
import 'package:ecommerce_app/database/database.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/features/launch/launch_screen.dart';
import 'package:ecommerce_app/features/login/login_screen.dart';
import 'package:ecommerce_app/features/product_details/product_details_screen.dart';
import 'package:ecommerce_app/features/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(
    () async => await SharedPreferences.getInstance(),
    permanent: true,
  );

  await Get.putAsync(() async {
    final ProductDatabase productDatabase =
        await $FloorProductDatabase.databaseBuilder('product.db').build();
    return productDatabase;
  }, permanent: true);
  runApp(
    GetMaterialApp(
      initialRoute: RouteNames.init,
      getPages: [
        GetPage(name: RouteNames.init, page: () => LaunchScreen()),
        GetPage(
          name: RouteNames.login,
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: RouteNames.products,
          page: () => ProductsScreen(),
          binding: ProductsBinding(),
        ),
        GetPage(
          name: RouteNames.productDetails,
          page: () => ProductDetailsScreen(),
          binding: ProductDetailsBinding(),
        ),
        GetPage(
          name: RouteNames.cart,
          page: () => CartScreen(),
          binding: CartBinding(),
        ),
        GetPage(
          name: RouteNames.checkOut,
          page: () => CheckoutScreen(),
          binding: CheckoutBinding(),
        ),
      ],
    ),
  );
}
