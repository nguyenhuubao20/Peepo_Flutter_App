part of 'product_banner_bloc.dart';

sealed class ProductBannerEvent extends Equatable {
  const ProductBannerEvent();
}

final class FetchProductBanner extends ProductBannerEvent {
  final int page;
  @override
  FetchProductBanner({required this.page});

  @override
  List<Object?> get props => [page];
}
