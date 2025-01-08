import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/domain/repositories.dart';

import '../../../../domain/entities.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProduct>(_onFetchProduct);
  }

  Future<void> _onFetchProduct(
      FetchProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      final response = await productRepository.getProducts(event.page, 10);

      final products = response.listResult;
      final totalPages = response.totalPage;
      final hasMore = event.page < totalPages;

      if (products.isEmpty && event.page == 1) {
        emit(ProductEmpty());
      } else {
        emit(ProductLoaded(
          products: products,
          hasMore: hasMore,
          totalPages: totalPages,
        ));
      }
    } catch (e) {
      emit(ProductError(message: "Đã xảy ra lỗi: ${e.toString()}"));
    }
  }
}
