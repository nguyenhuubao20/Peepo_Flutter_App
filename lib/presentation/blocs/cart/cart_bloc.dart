import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitialState()) {
    on<LoadCartEvent>(_onLoadCart);
    // on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadCart(CartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      final items = await cartRepository.loadCart();
      emit(CartLoadedState(items));
    } catch (e) {
      emit(CartErrorState("Không thể tải giỏ hàng. Lỗi: ${e.toString()}"));
    }
  }

  // Future<void> _onAddToCart(
  //     AddToCartEvent event, Emitter<CartState> emit) async {
  //   try {
  //     await cartRepository.addToCart(event.item);
  //     final updatedItems = await cartRepository.loadCart();
  //     emit(CartLoadedState(updatedItems));
  //   } catch (e) {
  //     emit(CartErrorState("Không thể thêm sản phẩm. Lỗi: ${e.toString()}"));
  //   }
  // }

  Future<void> _onRemoveFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      await cartRepository.removeFromCart(event.itemId);
      final updatedItems = await cartRepository.loadCart();
      emit(CartLoadedState(updatedItems));
    } catch (e) {
      emit(CartErrorState("Không thể xóa sản phẩm. Lỗi: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateCartItem(
      UpdateCartItemEvent event, Emitter<CartState> emit) async {
    try {
      await cartRepository.updateCartItem(event.item);
      final updatedItems = await cartRepository.loadCart();
      emit(CartLoadedState(updatedItems));
    } catch (e) {
      emit(CartErrorState("Không thể cập nhật sản phẩm. Lỗi: ${e.toString()}"));
    }
  }

  Future<void> _onClearCart(
      ClearCartEvent event, Emitter<CartState> emit) async {
    try {
      await cartRepository.clearCart();
      emit(CartLoadedState([]));
    } catch (e) {
      emit(CartErrorState("Không thể xóa giỏ hàng. Lỗi: ${e.toString()}"));
    }
  }
}

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final CartRepository cartRepository;

  AddToCartBloc({required this.cartRepository})
      : super(AddToCartInitialState()) {
    on<AddToCartEvent>(_onAddToCart);
  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<AddToCartState> emit) async {
    emit(AddToCartLoadingState());
    try {
      await cartRepository.addToCart(event.item);
      emit(AddToCartSuccessState());
    } catch (e) {
      emit(
          AddToCartErrorState("Không thể thêm sản phẩm. Lỗi: ${e.toString()}"));
    }
  }
}

class UpdateCartItemBloc extends Bloc<CartCountEvent, UpdateCartQuantityState> {
  final CartRepository cartRepository;

  UpdateCartItemBloc({required this.cartRepository})
      : super(UpdateCartQuantityInitialState()) {
    on<UpdateCartQuantity>(_onUpdateCartItem);
  }

  Future<void> _onUpdateCartItem(
      UpdateCartQuantity event, Emitter<UpdateCartQuantityState> emit) async {
    emit(UpdateCartQuantityLoadingState());
    try {
      await cartRepository.updateCartQuantity(
          event.item, event.count, event.isIncrease);
      emit(UpdateCartQuantitySuccessState());
    } catch (e) {
      emit(UpdateCartQuantityErrorState(
          "Không thể cập nhật sản phẩm. Lỗi: ${e.toString()}"));
    }
  }
}
