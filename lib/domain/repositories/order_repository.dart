import 'package:peefo/domain/entities/order/create_order.dart';
import 'package:peefo/domain/entities/order/order_response.dart';

import '../../data/utils/base_response.dart';

abstract class OrderRepository {
  Future<OrderResponse> createOrder(CreateOrder order);
  Future<List<OrderResponse>> getOrders();
  Future<OrderResponse> getOrder(String id);
  Future<BaseResponse<OrderResponse>> getOrdersByUserId(String userId);
}
