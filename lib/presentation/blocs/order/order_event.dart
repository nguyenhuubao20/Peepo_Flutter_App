import '../../../domain/entities/order/create_order.dart';

abstract class OrderEvent {}

class AddOrderEvent extends OrderEvent {
  final CreateOrder createOrder;

  AddOrderEvent(this.createOrder);
}

class GetOrdersByUserEvent extends OrderEvent {
  final String userId;

  GetOrdersByUserEvent(this.userId);
}
