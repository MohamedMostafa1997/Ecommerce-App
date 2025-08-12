import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:ecommerce_app/features/products/products_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsController extends GetxController {
  final ProductsRepo productRepo = ProductsRepo();
  final CartRepo cartRepo;

  ProductsController(this.cartRepo );

  final RxBool isLoading = false.obs;

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
      filteredProducts.assignAll(products);
    } else {
      errorMessage.value = result['message'];
    }
  }

  void filterProduct(String item) {
    if (item.isEmpty) {
      filteredProducts.assignAll(allProducts);
    } else {
      final List<Product> filtered =
          allProducts.where((product) {
            return product.name.toLowerCase().contains(item.toLowerCase());
          }).toList();
          
      filteredProducts.assignAll(filtered);
    }
  }

  Future<void> clearCache() async {

    await cartRepo.deleteAllProducts();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
