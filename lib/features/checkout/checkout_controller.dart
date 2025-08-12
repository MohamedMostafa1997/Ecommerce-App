import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:get/state_manager.dart';

class CheckoutController extends GetxController {
  final CartRepo cartRepo;
  CheckoutController(this.cartRepo);

  RxList<Product> cartItems = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> fetchCheckoutItems() async {
    try {
      isLoading.value = true;

      final List<Product> items = await cartRepo.fetchCartItems();
      cartItems.assignAll(items);
      if (cartItems.isEmpty) {
        errorMessage.value = "No items to checkout";
      }

      cartItems.assignAll(items);
    } catch (e) {
      errorMessage.value = "Failed to load items";
    } finally {
      isLoading.value = false;
    }
  }

  double getSingleProductPrice(Product product) =>
      cartRepo.calculateSingleProductTotal(product);

  double get totalPrice => cartRepo.calculateTotalPrice(cartItems);
}
