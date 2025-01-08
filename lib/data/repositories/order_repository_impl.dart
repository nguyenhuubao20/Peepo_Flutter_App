import 'package:peefo/data/models/order/create_order_model.dart';
import 'package:peefo/domain/entities/order/create_order.dart';
import 'package:peefo/domain/entities/order/order_response.dart';

import '../../domain/repositories/order_repository.dart';
import '../constant/api_constant.dart';
import '../models/order/order_response_model.dart';
import '../utils/base_response.dart';
import '../utils/exception_handler.dart';
import '../utils/request.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<OrderResponse> createOrder(CreateOrder order) async {
    try {
      final orderModel = CreateOrderModel.fromEntity(order);

      final response = await request.post(
        '${ApiConstant.CREATE_ORDER}',
        data: orderModel.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        return OrderResponseModel.fromJson(response.data);
      } else {
        throw ApiException(
          errorCode: response.statusCode,
          errorMessage: response.statusMessage ?? 'Lỗi không xác định',
          errorStatus: response.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<OrderResponse> getOrder(String id) {
    // TODO: implement getOrder
    throw UnimplementedError();
  }

  @override
  Future<List<OrderResponse>> getOrders() {
    // TODO: implement getOrders
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<OrderResponse>> getOrdersByUserId(String userId) async {
    try {
      final response = await request.get(
        '${ApiConstant.GET_ORDER_BY_USER_ID}/$userId',
        queryParameters: {
          'userId': userId,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> data = response.data['listResult'] ?? [];
        List<OrderResponseModel> productList =
            data.map((item) => OrderResponseModel.fromJson(item)).toList();

        return BaseResponse<OrderResponse>(
          page: response.data['page'] ?? 0,
          totalPage: response.data['totalPage'] ?? 0,
          limit: response.data['limit'] ?? 0,
          listResult: productList,
        );
      } else {
        throw ApiException(
          errorCode: response.statusCode,
          errorMessage: response.statusMessage ?? 'Lỗi không xác định',
          errorStatus: response.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
