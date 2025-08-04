import 'package:ecommerce_app/models/entity/product.dart';
import 'package:ecommerce_app/screens/cart/cart_controller.dart';
import 'package:ecommerce_app/screens/cart/cart_item_widget.dart';
import 'package:ecommerce_app/screens/cart/cart_repo.dart';
import 'package:ecommerce_app/utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';

class Cart extends StatefulWidget {
  final CartRepo cartRepo;
  const Cart({super.key, required this.cartRepo});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late final CartController controller;

  @override
  void initState() {

    super.initState();
    
    controller = CartController(widget.cartRepo);

    controller.fetchCartItems();
 
  }

  @override
  Widget build(BuildContext context) {
    ever(controller.snackBarMessage, (message) {
      if (message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        controller.snackBarMessage.value = '';
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final Product product = controller.cartItems[index];
                  return CartItemWidget(
                    product: product,
                    controller: controller,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed:
                    () => Navigator.pushNamed(context, RouteNames.cheakOut),
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
