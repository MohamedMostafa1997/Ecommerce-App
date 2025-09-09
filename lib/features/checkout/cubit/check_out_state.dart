part of 'check_out_cubit.dart';

sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckoutLoading extends CheckOutState {}

final class CheckoutLoaded extends CheckOutState {
  final List<Product> cartItems;

  CheckoutLoaded(this.cartItems);
}

final class CheckoutError extends CheckOutState {
  final String message;

  CheckoutError(this.message);
}
