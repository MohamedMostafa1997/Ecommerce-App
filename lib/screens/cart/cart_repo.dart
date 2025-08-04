import 'package:ecommerce_app/models/data_base/database.dart';
import 'package:ecommerce_app/models/entity/product.dart';

class CartRepo {
  final ProductDatabase database;

  CartRepo(this.database);

  Future<List<Product>> fetchCartItems() async {
    return await database.productDao.getProduct();
  }

  Future<void> increaseQuantity(Product product) async {
    final newQuantity = product.quantity + 1;

    await database.productDao.updateQuantity(product.id, newQuantity);
  }

  Future<void> decreaseQuantity(Product product) async {
    final newQuantity = product.quantity - 1;
    await database.productDao.updateQuantity(product.id, newQuantity);
  }

  Future<void> removeItem(Product product) async {
    await database.productDao.deleteProduct(product);
  }
}
