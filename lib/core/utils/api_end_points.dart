class ApiEndPoints {
  static const String auth = "https://fakestoreapi.com/auth/login";
  static const String allProducts = "https://fakestoreapi.com/products";
  static String singleProduct(int id) =>
      "https://fakestoreapi.com/products/$id";
}
