import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/service/cart_repo.dart';
import 'package:ecommerce_app/features/product_details/product_details_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo productDetailsRepo;
  final CartRepo cartRepo;

  ProductDetailsCubit({ required this.productDetailsRepo, required this.cartRepo})
    : super(ProductDetailsInitial());

  Future<void> fetchSingleProduct(int productID) async {
    emit(ProductDetailsLoading());

    final result  = await productDetailsRepo.getSingleProduct(productID);

    if (result['success'] == true) {
      final Product product = result['data'];
       final bool isInCart = await cartRepo.isProductInCart(product.id);

      emit(ProductDetailsLoaded(product: product, isInCart: isInCart));
    }else{
      emit(ProductDetailsError(result['message']));
    }
  }

  Future<void> setIsInCartStatus(int productID) async {
    if(state is ProductDetailsLoaded){
      final current = state as ProductDetailsLoaded;
      final bool isInCart = await cartRepo.isProductInCart(productID);
      emit(ProductDetailsLoaded(product: current.product, isInCart: isInCart));
    }
  }

  Future<void> addToCart(Product product) async {
    await cartRepo.insertToDatabase(product);
    emit(ProductDetailsLoaded(product: product, isInCart: true));
  }


  Future<void> toggleCart(Product product) async {
    if (state is ProductDetailsLoaded){
      final current = state as ProductDetailsLoaded;
      if(current.isInCart){
        await cartRepo.removeItem(product);
        emit(ProductDetailsLoaded(product: product, isInCart: false));
      }else {
        await addToCart(product);
      }
    }
  }
}
