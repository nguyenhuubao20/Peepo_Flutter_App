part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object?> get props => [];
}

// State for product detail

final class ProductDetailLoaded extends ProductDetailState {
  final Product product;

  ProductDetailLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

final class ProductDetailError extends ProductDetailState {
  final String message;

  ProductDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailEmpty extends ProductDetailState {}
