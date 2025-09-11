import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  final CartRepo cartRepo;


  CheckOutCubit({required this.cartRepo}) : super(CheckOutInitial());

  Future<void> fetchCheckoutItems() async {
    try {
      emit(CheckoutLoading());
      final List<Product>  cartItems = await cartRepo.fetchCartItems();

      if (cartItems.isEmpty) {
        emit(CheckoutError("No items Found"));
      } else {
        emit(CheckoutLoaded(cartItems));
      }
    } catch (e) {
      emit(CheckoutError("Failed to load items"));
    }
  }

  double getSingleProductPrice(Product product) =>
      cartRepo.calculateSingleProductTotal(product);

  double getTotalPrice(List<Product> products) => cartRepo.calculateTotalPrice(products);
}
