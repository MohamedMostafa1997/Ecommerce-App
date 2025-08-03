import 'package:ecommerce_app/models/data_base/database.dart';
import 'package:ecommerce_app/models/entity/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final ProductDatabase database;

  CartController(this.database);

  RxList cartItems = <Product>[].obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  Future fetchCartItems () async {

    // try {
    //   isLoading.value = true;
    //   final items = await database.productDao.get
    // }

  }

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }




}
