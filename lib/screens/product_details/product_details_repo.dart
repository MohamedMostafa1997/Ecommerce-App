import 'dart:convert';
import 'package:ecommerce_app/models/data_base/database.dart';
import 'package:ecommerce_app/models/entity/product.dart';
import 'package:ecommerce_app/utils/api_consts.dart';
import 'package:http/http.dart' as http;

class ProductDetailsRepo {
  final ProductDatabase database;
  ProductDetailsRepo(this.database);
  Future<Map<String, dynamic>> getSingleProduct(int id) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.singleProduct(id)),
      );

      final Map<String, dynamic> result = jsonDecode(response.body);
      final Product product = Product.fromJson(result);

      return {"success": true, "data": product};
    } catch (e) {
      return {
        "success": false,
        "message": "Please check your internet connection.",
      };
    }
  }

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
}
