import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepo;
  CartCubit({required this.cartRepo}) : super(CartInitial());

  Future<void> fetchCartItems() async {
    emit(CartLoading());
    try {
      final List<Product> items = await cartRepo.fetchCartItems();
      if (items.isEmpty) {
        emit(CartError("No Product Items Found"));
      } else {
        emit(CartLoaded(items));
      }
    } catch (e) {
      emit(CartError("Failed to load cart items. Please try again."));
    }
  }

  Future<void> increaseQuantity(Product product) async {
    await cartRepo.increaseQuantity(product);
    await fetchCartItems();
  }

  Future<void> decreaseQuantity(Product product) async {
    if (product.quantity > 1) {
      await cartRepo.decreaseQuantity(product);
      await fetchCartItems();
    } else {
      emit(CartActionMessage("Can't decrease quantity"));
      await fetchCartItems();
    }
  }

  Future<void> removeItem(Product product) async {
    await cartRepo.removeItem(product);
    await fetchCartItems();
  }

  Future<void> addToCart(Product product) async {
    await cartRepo.insertToDatabase(product);
  }

  Future<void> setIsInCartStatus(int productID) async {
    final bool isInCart = await cartRepo.isProductInCart(productID);
    emit(CartItemStatus(productId: productID, isInCart: isInCart));
  }

  Future<void> toggleCart(Product product) async {
    final bool isInCart = await cartRepo.isProductInCart(product.id);

    if (isInCart) {
      await cartRepo.removeItem(product);
      emit(CartItemStatus(productId: product.id, isInCart: false));
    } else {
      await addToCart(product);
      emit(CartItemStatus(productId: product.id, isInCart: true));
    }
  }
}
