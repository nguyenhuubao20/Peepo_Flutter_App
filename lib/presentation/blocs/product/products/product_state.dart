part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

// State for product list

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasMore;
  final int totalPages;

  ProductLoaded({
    required this.products,
    this.hasMore = true,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [products, hasMore, totalPages];
}

final class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class ProductEmpty extends ProductState {}
