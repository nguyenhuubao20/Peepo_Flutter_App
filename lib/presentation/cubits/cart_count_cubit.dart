import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/presentation/cubits/cart_count_state.dart';

import '../../domain/repositories/cart_repository.dart';

class CartCountCubit extends Cubit<CartCountState> {
  final CartRepository cartRepository;

  CartCountCubit({required this.cartRepository})
      : super(CartCountInitialState());

  Future<void> loadCartCount() async {
    emit(CartCountLoadingState());
    try {
      final count = await cartRepository.loadNumberOfCart();
      emit(CartCountLoadedState(count));
    } catch (e) {
      emit(CartCountErrorState(
          "Không thể tải số lượng sản phẩm. Lỗi: ${e.toString()}"));
    }
  }
}
