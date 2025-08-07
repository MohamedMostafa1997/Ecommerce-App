import 'package:ecommerce_app/models/data_base/database.dart';
import 'package:ecommerce_app/models/entity/product.dart';

class CartRepo {
  final ProductDatabase database;

  CartRepo(this.database);

  Future<void> insertToDatabase(Product product) async {
    await database.productDao.insertProduct(
      Product(
        id: product.id,
        name: product.name,
        price: product.price,
        image: product.image,
        category: product.category,
        description: product.description,
        rating: product.rating,
        quantity: 1,
      ),
    );
  }

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

  double calculateTotalPrice(List<dynamic> cartItems) {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }
}
