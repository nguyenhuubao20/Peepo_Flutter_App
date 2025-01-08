import '../../../domain/entities.dart';

abstract class CartEvent {}

abstract class CartCountEvent {}

// add to cart
class AddToCartEvent extends CartEvent {
  final CartItem item;

  AddToCartEvent(this.item);
}

class RemoveFromCartEvent extends CartEvent {
  final String itemId;

  RemoveFromCartEvent(this.itemId);
}

class UpdateCartItemEvent extends CartEvent {
  final CartItem item;

  UpdateCartItemEvent(this.item);
}

class LoadCartEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {}

// cart count

class LoadCartCount extends CartCountEvent {}

class UpdateCartQuantity extends CartCountEvent {
  final CartItem item;
  final int count;
  bool isIncrease;

  UpdateCartQuantity(this.item, this.count, this.isIncrease);
}
