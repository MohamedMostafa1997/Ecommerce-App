import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/product_details/product_details_repo.dart';
import 'package:ecommerce_app/features/products/entities/product.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRepo productDetailsRepo;

  ProductDetailsCubit({required this.productDetailsRepo})
    : super(ProductDetailsInitial());

  Future<void> fetchSingleProduct(int productID) async {
    emit(ProductDetailsLoading());

    final Map<String, dynamic> result = await productDetailsRepo
        .getSingleProduct(productID);

    if (result['success'] == true) {
      final Product product = result['data'];

      emit(ProductDetailsLoaded(product: product));
    } else {
      emit(ProductDetailsError(result['message']));
    }
  }
}
