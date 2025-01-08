import '../entities/order_item/order_item_response.dart';

abstract class OrderItemRepository {
  Future<bool> createOrderItem(String orderId);
  Future<List<OrderItemResponse>> getOrderItems();
  Future<OrderItemResponse> getOrderItem(String id);
}
