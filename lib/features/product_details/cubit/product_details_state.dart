part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading  extends ProductDetailsInitial{}

final class ProductDetailsLoaded  extends ProductDetailsInitial{
   final Product product ; 
   final bool isInCart ;

  ProductDetailsLoaded({required this.product, required this.isInCart}); 

}

final class ProductDetailsError extends ProductDetailsInitial{
  final String message ; 
  ProductDetailsError(this.message);
}
