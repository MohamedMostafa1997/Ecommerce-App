import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM Product')
  Future<List<Product>> getProduct();

  @Query('UPDATE Product SET quantity = :quantity WHERE id = :id')
  Future<void> updateQuantity(int id, int quantity);

  @Query('DELETE FROM Product')
  Future<void> deleteAllMovies();

  @insert
  Future<void> insertProduct(Product product);

  @update
  Future<void> updateProduct(Product product);

  @delete
  Future<void> deleteProduct(Product product);
}
