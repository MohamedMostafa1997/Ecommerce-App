import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/core/utils/route_names.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:ecommerce_app/features/products/products_controller.dart';
import 'package:ecommerce_app/features/products/widgets/error_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  final CartRepo cartRepo;

  const ProductsScreen({super.key, required this.cartRepo});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductsController controller;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = Get.put(ProductsController(widget.cartRepo));
    controller.fetchProducts();
  }

  void logout() async {
    await controller.clearCache();

    if (mounted) {
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }
  }

  void goToCart() {
    Navigator.pushNamed(context, RouteNames.cart);
  }

  void goToDetails(int productId) {
    Navigator.pushNamed(
      context,
      RouteNames.productDetails,
      arguments: productId,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
          ),
        ),
        actions: [
          IconButton(onPressed: goToCart, icon: Icon(Icons.shopping_cart)),
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: controller.filterProduct,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.errorMessage.isNotEmpty) {
                return ErrorProducts(
                  message: controller.errorMessage.value,
                  onRetry: controller.fetchProducts,
                );
              }
              if (controller.filteredProducts.isEmpty) {
                return Center(child: Text("No products found."));
              }

              return GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final Product product = controller.filteredProducts[index];
                  return GestureDetector(
                    onTap: () => goToDetails(product.id),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              product.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
