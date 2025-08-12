import 'package:ecommerce_app/database/database.dart';
import 'package:ecommerce_app/database/product_dao.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';

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

  Future<bool> isProductInCart(int productId) async {
    final products = await fetchCartItems();
    return products.any((item) => item.id == productId);
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

  Future<void> deleteAllProducts() async {
    await database.productDao.deleteAllMovies();
  }

  double calculateTotalPrice(List<dynamic> cartItems) {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }
}
