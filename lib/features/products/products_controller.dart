import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:ecommerce_app/features/products/products_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsController extends GetxController {
  final ProductsRepo productRepo = Get.find();
  final CartRepo cartRepo = Get.find();

  final RxBool isLoading = false.obs;

  final RxBool isSearching = false.obs;

  final RxString errorMessage = "".obs;

  final RxList<Product> allProducts = <Product>[].obs;

  final RxList<Product> filteredProducts = <Product>[].obs;

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await productRepo.getAllProducts();
    isLoading.value = false;

    if (result['success'] == true) {
      final List<Product> products = result["data"];
      allProducts.assignAll(products);
      filteredProducts.clear();
      isSearching.value = false;
    } else {
      errorMessage.value = result['message'];
    }
  }

  void filterProduct(String item) {
    if (item.isEmpty) {
      filteredProducts.clear();
      isSearching.value = false;
    } else {
      filteredProducts.assignAll(
        allProducts.where((product) =>
          product.name.toLowerCase().contains(item.toLowerCase())
        ),
      );

      isSearching.value = true;
    }
  }

  Future<void> clearCache() async {
    await cartRepo.deleteAllProducts();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
