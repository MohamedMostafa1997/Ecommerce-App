import 'package:ecommerce_app/core/routing/route_names.dart';
import 'package:ecommerce_app/features/products/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:ecommerce_app/features/products/widgets/error_products.dart';
import 'package:ecommerce_app/features/products/widgets/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().fetchProducts();
  }

  void logout() async {
    await context.read<ProductsCubit>().clearCache();

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
              onChanged: (value) {
                context.read<ProductsCubit>().filterProducts(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductsError) {
                  return ErrorProducts(
                    message: state.message,
                    onRetry:
                        () => context.read<ProductsCubit>().fetchProducts(),
                  );
                }
                List<Product> products = [];

                if (state is ProductsLoaded) {
                  products = state.products;
                } else if (state is ProductsSearched) {
                  products = state.filteredProducts;
                }

                if (products.isEmpty) {
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
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      product: products[index],
                      onTap: () => goToDetails(products[index].id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
