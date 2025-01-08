import '../../domain/entities.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasource/cart_local_datasource.dart';
import '../model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDatasource _cartStorage;

  CartRepositoryImpl(this._cartStorage);

  @override
  Future<void> addToCart(CartItem item) async {
    final items = await _cartStorage.loadItems();

    final cartItemModel = CartItemModel.fromEntity(item);

    final existingItemIndex = items.indexWhere(
      (existingItem) =>
          existingItem.productId == cartItemModel.productId &&
          existingItem.color == cartItemModel.color,
    );

    if (existingItemIndex != -1) {
      final existingItem = items[existingItemIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + cartItemModel.quantity,
      );
      items[existingItemIndex] = updatedItem;
    } else {
      items.add(cartItemModel);
    }

    await _cartStorage.saveItems(items);
    print('Added to cart: $item');
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    final items = await _cartStorage.loadItems();
    items.removeWhere((item) => item.id == itemId);
    await _cartStorage.saveItems(items);
  }

  @override
  Future<void> updateCartItem(CartItem item) async {
    final items = await _cartStorage.loadItems();
    final cartItemModel = CartItemModel.fromEntity(item);

    final index = items.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      items[index] = cartItemModel;
      await _cartStorage.saveItems(items);
    }
  }

  @override
  Future<void> clearCart() async {
    await _cartStorage.clearStorage();
  }

  @override
  Future<List<CartItem>> loadCart() async {
    return await _cartStorage.loadItems();
  }

  @override
  Future<int> loadNumberOfCart() async {
    List<CartItem> cartItems = await loadCart();
    return cartItems.length;
  }

  @override
  Future<void> updateCartQuantity(
      CartItem item, int count, bool isIncrease) async {
    final items = await _cartStorage.loadItems();
    final cartItemModel = CartItemModel.fromEntity(item);

    final index = items.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      final updatedItem = cartItemModel.copyWith(
        quantity: isIncrease
            ? cartItemModel.quantity + count
            : cartItemModel.quantity - count,
      );
      items[index] = updatedItem;
      await _cartStorage.saveItems(items);
    }
  }
}
