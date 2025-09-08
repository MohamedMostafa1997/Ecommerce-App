import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;
  final CartCubit cartCubit;

  const CartItemWidget({
    super.key,
    required this.product,
    required this.cartCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(product.image, width: 80, height: 80),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => cartCubit.decreaseQuantity(product),
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Text("${product.quantity}"),
                IconButton(
                  onPressed: () => cartCubit.increaseQuantity(product),
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () => cartCubit.removeItem(product),
            ),
          ],
        ),
      ),
    );
  }
}
