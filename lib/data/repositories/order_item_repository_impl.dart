import '../../domain/entities/order_item/order_item_response.dart';
import '../../domain/repositories/order_item_repository.dart';
import '../constant/api_constant.dart';
import '../datasource/cart_local_datasource.dart';
import '../models/order_item/create_order_item_model.dart';
import '../utils/exception_handler.dart';
import '../utils/request.dart';

class OrderItemRepositoryImpl implements OrderItemRepository {
  final CartLocalDatasource _cartStorage;

  OrderItemRepositoryImpl(this._cartStorage);

  @override
  Future<bool> createOrderItem(String orderId) async {
    try {
      List<CreateOrderItemModel> orderItems = [];
      var productsOnCart = await _cartStorage.loadItems();

      for (var product in productsOnCart) {
        final orderItemModel = CreateOrderItemModel(
          orderID: orderId,
          productID: product.productId,
          quantity: product.quantity ?? 0,
          unitPrice: (product.price ?? 0) * (product.quantity ?? 0),
          status: 'ACTIVE',
        );
        orderItems.add(orderItemModel);
      }

      for (var orderItem in orderItems) {
        final response = await request.post(
          ApiConstant.CREATE_ORDER_ITEM,
          data: orderItem.toJson(),
        );

        if (response.statusCode != 200 || response.data == null) {
          return false;
        }
      }
      return true;
    } catch (e) {
      ExceptionHandler.handleException(e);
      return false;
    }
  }

  @override
  Future<OrderItemResponse> getOrderItem(String id) {
    // TODO: implement getOrderItem
    throw UnimplementedError();
  }

  @override
  Future<List<OrderItemResponse>> getOrderItems() {
    // TODO: implement getOrderItems
    throw UnimplementedError();
  }
}
