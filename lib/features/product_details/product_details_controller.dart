import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/product_details/product_details_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final CartRepo cartRepo = Get.find();
  final ProductDetailsRepo productDetailsRepo = Get.find();

  final Rxn<Product> product = Rxn<Product>(null);

  final RxBool isLoading = false.obs;

  final RxBool isInCart = false.obs;

  final RxString errorMessage = "".obs;

  Future<void> fetchSingleProduct(productID) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await productDetailsRepo.getSingleProduct(productID);

    if (result['success'] == true) {
      product.value = result['data'];
    } else {
      errorMessage.value = result['message'];
    }

    isLoading.value = false;
  }

  Future<void> setIsInCartStatus(int productID) async {
    isInCart.value = await cartRepo.isProductInCart(productID);
  }

  Future<void> addToCart(product) async {
    await cartRepo.insertToDatabase(product);
  }

  Future<void> toggleCart(Product product) async {
    if (isInCart.value) {
      await cartRepo.removeItem(product);
      isInCart.value = false;
    } else {
      await addToCart(product);
      isInCart.value = true;
    }
  }
}
