import 'package:peefo/domain/entities/order/order_response.dart';

abstract class OrderState {}

class AddOrderInitialState extends OrderState {}

class AddOrderLoadingState extends OrderState {}

class AddOrderSuccessState extends OrderState {
  final OrderResponse orderResponse;

  AddOrderSuccessState(this.orderResponse);
}

class AddOrderErrorState extends OrderState {
  final String errorMessage;

  AddOrderErrorState(this.errorMessage);
}

// GetOrdersByUser

class GetOrdersByUserInitialState extends OrderState {}

class GetOrdersByUserLoadingState extends OrderState {}

class GetOrdersByUserSuccessState extends OrderState {
  final List<OrderResponse> orders;

  GetOrdersByUserSuccessState(this.orders);
}

class GetOrdersByUserErrorState extends OrderState {
  final String errorMessage;

  GetOrdersByUserErrorState(this.errorMessage);
}
