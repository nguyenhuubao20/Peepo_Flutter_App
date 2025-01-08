import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/domain/repositories.dart';

import '../../../../domain/entities.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productRepository;

  ProductDetailBloc({required this.productRepository})
      : super(ProductDetailInitial()) {
    on<FetchProductDetail>(_onFetchProductDetail);
  }

  Future<void> _onFetchProductDetail(
      FetchProductDetail event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final product = await productRepository.getProduct(event.id);
      emit(ProductDetailLoaded(product: product));
    } catch (e) {
      emit(ProductDetailError(message: e.toString()));
    }
  }
}
