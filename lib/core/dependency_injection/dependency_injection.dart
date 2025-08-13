import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/cart/cart_controller.dart';
import 'package:ecommerce_app/features/checkout/checkout_controller.dart';
import 'package:ecommerce_app/features/login/login_controller.dart';
import 'package:ecommerce_app/features/login/login_repo.dart';
import 'package:ecommerce_app/features/product_details/product_details_controller.dart';
import 'package:ecommerce_app/features/product_details/product_details_repo.dart';
import 'package:ecommerce_app/features/products/products_controller.dart';
import 'package:ecommerce_app/features/products/products_repo.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<LoginRepo>(() => LoginRepo());
  }
}

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(() => ProductsController());
    Get.lazyPut<ProductsRepo>(() => ProductsRepo());
    Get.lazyPut<CartRepo>(() => CartRepo());
  }
}

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
    Get.lazyPut<ProductDetailsRepo>(() => ProductDetailsRepo());
    Get.lazyPut<CartRepo>(() => CartRepo());
  }
}

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<CartRepo>(() => CartRepo());
  }
}

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController());
    Get.lazyPut<CartRepo>(() => CartRepo());
  }
}
