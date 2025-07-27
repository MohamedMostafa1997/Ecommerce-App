import 'dart:convert';

import 'package:ecommerce_app/models/entity/product.dart';
import 'package:ecommerce_app/utils/api_consts.dart';
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
