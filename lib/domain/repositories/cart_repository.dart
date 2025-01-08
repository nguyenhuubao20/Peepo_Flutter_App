import '../entities.dart';

abstract class CartRepository {
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String itemId);
  Future<void> updateCartItem(CartItem item);
  Future<void> clearCart();
  Future<List<CartItem>> loadCart();
  Future<int> loadNumberOfCart();
  Future<void> updateCartQuantity(CartItem item, int count, bool isIncrease);
}
