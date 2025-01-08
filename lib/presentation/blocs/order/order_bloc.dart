import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/domain/repositories/order_item_repository.dart';
import 'package:peefo/presentation/blocs/order/order_event.dart';
import 'package:peefo/presentation/blocs/order/order_state.dart';

import '../../../domain/repositories/order_repository.dart';

class AddOrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final OrderItemRepository orderItemRepository;

  AddOrderBloc(
      {required this.orderRepository, required this.orderItemRepository})
      : super(AddOrderInitialState()) {
    on<AddOrderEvent>(_onAddOrder);
  }

  Future<void> _onAddOrder(
      AddOrderEvent event, Emitter<OrderState> emit) async {
    emit(AddOrderLoadingState());
    try {
      final order = await orderRepository.createOrder(event.createOrder);
      await orderItemRepository.createOrderItem(order.id ?? "");
      emit(AddOrderSuccessState(order));
    } catch (e) {
      emit(AddOrderErrorState("Không thể đặt hàng. Lỗi: ${e.toString()}"));
    }
  }
}

class GetOrdersByUserBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  GetOrdersByUserBloc({required this.orderRepository})
      : super(GetOrdersByUserInitialState()) {
    on<GetOrdersByUserEvent>(_onGetOrdersByUser);
  }

  Future<void> _onGetOrdersByUser(
      GetOrdersByUserEvent event, Emitter<OrderState> emit) async {
    emit(GetOrdersByUserLoadingState());
    try {
      final orders = await orderRepository.getOrdersByUserId(event.userId);
      emit(GetOrdersByUserSuccessState(orders.listResult));
    } catch (e) {
      emit(GetOrdersByUserErrorState(
          "Không thể lấy danh sách đơn hàng. Lỗi: ${e.toString()}"));
    }
  }
}
