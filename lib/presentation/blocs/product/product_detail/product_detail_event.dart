part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

final class FetchProductDetail extends ProductDetailEvent {
  final String id;

  const FetchProductDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
