import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController(this.cartRepo);

  RxList cartItems = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString snackBarMessage = ''.obs;

  Future<void> fetchCartItems() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final List<Product> items = await cartRepo.fetchCartItems();
      cartItems.assignAll(items);
      if (cartItems.isEmpty) {
        errorMessage.value = "No Product Items Found";
      }
    } catch (e) {
      errorMessage.value = "Failed to load cart items. Please try again.";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> increaseQuantity(Product product) async {
    await cartRepo.increaseQuantity(product);
    await fetchCartItems();
  }

  Future<void> decreaseQuantity(Product product) async {
    if (product.quantity > 1) {
      await cartRepo.decreaseQuantity(product);
    } else {
      snackBarMessage.value = "Can't decrease quantity";
    }

    await fetchCartItems();
  }

  Future<void> removeItem(Product product) async {
    await cartRepo.removeItem(product);
    await fetchCartItems();
  }
}
