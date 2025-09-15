part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded({required this.products});
}

final class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}

final class ProductsSearched extends ProductsState {
  final List<Product> filteredProducts;
  final String query;

  ProductsSearched({required this.filteredProducts, required this.query});
}
