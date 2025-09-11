import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:ecommerce_app/features/products/products_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;
  final CartRepo cartRepo;

  List<Product> allProducts = [];

  ProductsCubit({required this.productsRepo, required this.cartRepo})
    : super(ProductsInitial());

  Future<void> fetchProducts() async {
    emit(ProductsLoading());
    final Map result = await productsRepo.getAllProducts();
    if (result['success'] == true) {
      allProducts = result['data'];
      emit(ProductsLoaded(products: allProducts));
    } else {
      emit(ProductsError(result['message']));
    }
  }
  //TODO:
  void filterProducts(String query) {
    if (query.isEmpty) {
      emit(ProductsLoaded(products: allProducts));
    } else {
      final filterd =
          allProducts
              .where(
                (product) =>
                    product.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

      emit(ProductsLoaded(products: filterd));
    }
  }

  Future<void> clearCache() async {
    await cartRepo.deleteAllProducts();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
