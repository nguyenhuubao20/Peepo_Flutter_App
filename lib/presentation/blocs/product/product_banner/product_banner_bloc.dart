import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/domain/repositories.dart';

import '../../../../domain/entities.dart';

part 'product_banner_event.dart';
part 'product_banner_state.dart';

class ProductBannerBloc extends Bloc<ProductBannerEvent, ProductBannerState> {
  final ProductRepository productRepository;

  ProductBannerBloc({required this.productRepository})
      : super(ProductBannerInitial()) {
    on<FetchProductBanner>(_onFetchProductBanner);
  }

  Future<void> _onFetchProductBanner(
      FetchProductBanner event, Emitter<ProductBannerState> emit) async {
    emit(ProductBannerLoading());
    try {
      final products = await productRepository.getProducts(1, 5);
      if (products.listResult.isEmpty) {
        emit(ProductBannerEmpty());
        return;
      }
      emit(ProductBannerLoaded(
        products: products.listResult,
      ));
    } catch (e) {
      emit(ProductBannerError(message: e.toString()));
    }
  }
}
