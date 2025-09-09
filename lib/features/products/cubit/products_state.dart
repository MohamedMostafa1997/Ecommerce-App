part of 'products_cubit.dart';

sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final bool isSearching;

  ProductsLoaded({required this.products, this.isSearching = false});
}

final class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}

