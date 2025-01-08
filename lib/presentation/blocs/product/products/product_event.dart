part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

final class FetchProduct extends ProductEvent {
  final int page;
  @override
  FetchProduct({this.page = 1});

  @override
  List<Object?> get props => [page];
}
