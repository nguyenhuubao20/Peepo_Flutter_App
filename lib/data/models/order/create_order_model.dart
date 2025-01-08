import '../../../domain/entities/order/create_order.dart';

class CreateOrderModel extends CreateOrder {
  CreateOrderModel({
    String? userID,
    String? status,
    double? totalAmount,
    String? reason,
    String? orderStatus,
    String? shippingAddress,
  }) : super(
          userID: userID,
          status: status,
          totalAmount: totalAmount,
          reason: reason,
          orderStatus: orderStatus,
          shippingAddress: shippingAddress,
        );

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderModel(
      userID: json['userID'],
      status: json['status'],
      totalAmount: json['totalAmount'],
      reason: json['reason'],
      orderStatus: json['orderStatus'],
      shippingAddress: json['shippingAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'status': status,
      'totalAmount': totalAmount,
      'reason': reason,
      'orderStatus': orderStatus,
      'shippingAddress': shippingAddress,
    };
  }

  CreateOrder toEntity() {
    return CreateOrder(
      userID: userID,
      status: status,
      totalAmount: totalAmount,
      reason: reason,
      orderStatus: orderStatus,
      shippingAddress: shippingAddress,
    );
  }

  static CreateOrderModel fromEntity(CreateOrder entity) {
    return CreateOrderModel(
      userID: entity.userID,
      status: entity.status,
      totalAmount: entity.totalAmount,
      reason: entity.reason,
      orderStatus: entity.orderStatus,
      shippingAddress: entity.shippingAddress,
    );
  }

  CreateOrderModel copyWith({
    String? userID,
    String? status,
    double? totalAmount,
    String? reason,
    String? orderStatus,
    String? shippingAddress,
  }) {
    return CreateOrderModel(
      userID: userID ?? this.userID,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      reason: reason ?? this.reason,
      orderStatus: orderStatus ?? this.orderStatus,
      shippingAddress: shippingAddress ?? this.shippingAddress,
    );
  }

  CreateOrderModel copyFromEntity(CreateOrder entity) {
    return CreateOrderModel(
      userID: entity.userID,
      status: entity.status,
      totalAmount: entity.totalAmount,
      reason: entity.reason,
      orderStatus: entity.orderStatus,
      shippingAddress: entity.shippingAddress,
    );
  }
}
