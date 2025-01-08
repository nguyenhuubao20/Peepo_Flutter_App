import 'package:equatable/equatable.dart';

import '../order_item/order_item_response.dart';

class OrderResponse extends Equatable {
  final String? id;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final String? createdBy;
  final String? modifiedBy;
  final String? status;
  final String? userId;
  final DateTime? orderDate;
  final double? totalAmount;
  final String? shippingAddress;
  final String? orderStatus;
  final String? orderCode;
  final String? reason;
  final List<OrderItemResponse>? orderItems;

  OrderResponse({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.userId,
    this.orderDate,
    this.totalAmount,
    this.shippingAddress,
    this.orderStatus,
    this.orderCode,
    this.reason,
    this.orderItems,
  });

  List<Object?> get props => [
        id,
        createdDate,
        modifiedDate,
        createdBy,
        modifiedBy,
        status,
        userId,
        orderDate,
        totalAmount,
        shippingAddress,
        orderStatus,
        orderCode,
        reason,
        orderItems,
      ];
}
