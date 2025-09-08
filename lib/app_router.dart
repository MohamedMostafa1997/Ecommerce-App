import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/core/utils/route_names.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/features/checkout/cubit/check_out_cubit.dart';
import 'package:ecommerce_app/features/launch/launch_screen.dart';
import 'package:ecommerce_app/features/login/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/login/login_repo.dart';
import 'package:ecommerce_app/features/login/login_screen.dart';
import 'package:ecommerce_app/features/product_details/cubit/product_details_cubit.dart';
import 'package:ecommerce_app/features/product_details/product_details_repo.dart';
import 'package:ecommerce_app/features/product_details/product_details_screen.dart';
import 'package:ecommerce_app/features/products/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/products/products_repo.dart';
import 'package:ecommerce_app/features/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.init:
        return MaterialPageRoute(builder: (_) => LaunchScreen());

      case RouteNames.login:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => LoginCubit(LoginRepo()),
                child: LoginScreen(),
              ),
        );
      case RouteNames.products:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) => ProductsCubit(
                      productsRepo: ProductsRepo(),
                      cartRepo: CartRepo(),
                    ),
                child: ProductsScreen(),
              ),
        );
      case RouteNames.productDetails:
        final productId = settings.arguments as int?;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (_) => ProductDetailsCubit(
                      productDetailsRepo: ProductDetailsRepo(),
                      cartRepo: CartRepo(),
                    ),
                child: ProductDetailsScreen(productId: productId!),
              ),
        );
      case RouteNames.cart:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => CartCubit(cartRepo: CartRepo()),
                child: CartScreen(),
              ),
        );
      case RouteNames.checkOut:
      return MaterialPageRoute(
        builder: (_)=> BlocProvider(
          create: (_)=> CheckOutCubit(cartRepo: CartRepo()),
          child: CheckoutScreen(),
           ));  
    }
    return null;
  }
}
