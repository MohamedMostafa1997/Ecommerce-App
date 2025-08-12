import 'dart:convert';
import 'package:ecommerce_app/core/utils/api_end_points.dart';
import 'package:ecommerce_app/database/database.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';

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
}
