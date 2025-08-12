import 'dart:convert';
import 'package:ecommerce_app/core/utils/api_end_points.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:http/http.dart' as http;

class ProductsRepo {
  Future<Map<String, dynamic>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(ApiEndPoints.allProducts));

      final List<dynamic> result = jsonDecode(response.body);

      final List<Product> products =
          result.map((product) => Product.fromJson(product)).toList();

      return {"success": true, "data": products};
    } catch (e) {
      return {
        "success": false,
        "message": "Please check your internet connection.",
      };
    }
  }
}
