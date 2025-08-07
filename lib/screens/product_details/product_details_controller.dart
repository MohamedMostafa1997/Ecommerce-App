import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/models/data_base/database.dart';
import 'package:ecommerce_app/models/entity/product.dart';
import 'package:ecommerce_app/screens/product_details/product_details_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final CartRepo cartRepo ; 
  final ProductDetailsRepo productDetailsRepo;

  ProductDetailsController(this.productDetailsRepo, this.cartRepo);

  final Rxn<Product> product = Rxn<Product>(null);

  final RxBool isLoading = false.obs;

  final RxString errorMessage = "".obs;

  Future<void> fetchSingleProduct(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await productDetailsRepo.getSingleProduct(id);

    if (result['success'] == true) {
      product.value = result['data'];
    } else {
      errorMessage.value = result['message'];
    }

    isLoading.value = false;
  }

  Future<void> addToCart(product) async {
    await cartRepo.insertToDatabase(product);
  }
}
