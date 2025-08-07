import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/models/entity/product.dart';
import 'package:get/state_manager.dart';

class CheakoutController extends GetxController {
  final CartRepo cartRepo;
  CheakoutController(this.cartRepo);

  RxList<Product> cartItems = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> fetchCheakoutItems() async {
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

  double get totalPrice => cartRepo.calculateTotalPrice(cartItems);
}
