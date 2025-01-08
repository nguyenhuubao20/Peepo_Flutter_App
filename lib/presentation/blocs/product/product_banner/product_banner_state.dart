part of 'product_banner_bloc.dart';

sealed class ProductBannerState extends Equatable {
  const ProductBannerState();

  @override
  List<Object?> get props => [];
}

final class ProductBannerLoaded extends ProductBannerState {
  final List<Product> products;

  ProductBannerLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

final class ProductBannerError extends ProductBannerState {
  final String message;

  ProductBannerError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProductBannerLoading extends ProductBannerState {}

final class ProductBannerInitial extends ProductBannerState {}

final class ProductBannerEmpty extends ProductBannerState {}
