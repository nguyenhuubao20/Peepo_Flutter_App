import '../../../domain/entities.dart';

abstract class CartState {}

abstract class AddToCartState {}

abstract class UpdateCartQuantityState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItem> items;

  CartLoadedState(this.items);
}

class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState(this.errorMessage);
}

class ClearCartState extends CartState {}

// add to cart
class AddToCartInitialState extends AddToCartState {}

class AddToCartLoadingState extends AddToCartState {}

class AddToCartSuccessState extends AddToCartState {}

class AddToCartErrorState extends AddToCartState {
  final String errorMessage;

  AddToCartErrorState(this.errorMessage);
}

// update cart quantity

class UpdateCartQuantityInitialState extends UpdateCartQuantityState {}

class UpdateCartQuantityLoadingState extends UpdateCartQuantityState {}

class UpdateCartQuantitySuccessState extends UpdateCartQuantityState {}

class UpdateCartQuantityErrorState extends UpdateCartQuantityState {
  final String errorMessage;

  UpdateCartQuantityErrorState(this.errorMessage);
}
