import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/product_details/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ProductDetailsCubit>().fetchSingleProduct(widget.productId);
    context.read<CartCubit>().setIsInCartStatus(widget.productId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ) ),
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsLoaded) {
            final product = state.product;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            product.image,
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$${product.price}',
                          style:  TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          product.description,
                          style: TextStyle(fontSize: 14, height: 1.5),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "Category: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                product.category,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              "Rating: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "${product.rating.rate} ⭐ (${product.rating.count})",
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, cartState) {
                            bool isInCart = false;
                            if (cartState is CartItemStatus &&
                                cartState.productId == product.id) {
                              isInCart = cartState.isInCart;
                            }
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isInCart
                                      ? Colors.grey
                                      : Colors.pinkAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  context.read<CartCubit>().toggleCart(product);
                                },
                                child: Text(
                                  isInCart ? "Added" : "Add to Cart",
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return  SizedBox();
        },
      ),
    );
  }
}
                       
