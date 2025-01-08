import 'package:peefo/data/models/order_item/order_item_response_model.dart';

import '../../../domain/entities/order/order_response.dart';

class OrderResponseModel extends OrderResponse {
  // Constructor
  OrderResponseModel({
    String? id,
    DateTime? createdDate,
    DateTime? modifiedDate,
    String? createdBy,
    String? modifiedBy,
    String? status,
    String? userId,
    DateTime? orderDate,
    double? totalAmount,
    String? shippingAddress,
    String? orderStatus,
    String? orderCode,
    String? reason,
    List<OrderItemResponseModel>? orderItems,
  }) : super(
          id: id,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          createdBy: createdBy,
          modifiedBy: modifiedBy,
          status: status,
          userId: userId,
          orderDate: orderDate,
          totalAmount: totalAmount,
          shippingAddress: shippingAddress,
          orderStatus: orderStatus,
          orderCode: orderCode,
          reason: reason,
          orderItems: orderItems,
        );

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      modifiedDate: DateTime.parse(json['modifiedDate']),
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      status: json['status'],
      userId: json['userId'],
      orderDate: DateTime.parse(json['orderDate']),
      totalAmount: json['totalAmount'],
      shippingAddress: json['shippingAddress'],
      orderStatus: json['orderStatus'],
      orderCode: json['orderCode'],
      reason: json['reason'],
      orderItems: (json['orderItems'] as List)
          .map((e) => OrderItemResponseModel.fromJson(e))
          .toList(),
    );
  }
}
