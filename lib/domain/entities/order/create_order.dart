import 'package:equatable/equatable.dart';

class CreateOrder extends Equatable {
  final String? userID;
  final String? status;
  final double? totalAmount;
  final String? reason;
  final String? orderStatus;
  final String? shippingAddress;

  CreateOrder({
    this.userID,
    this.status,
    this.totalAmount,
    this.reason,
    this.orderStatus,
    this.shippingAddress,
  });

  List<Object?> get props => [
        userID,
        status,
        totalAmount,
        reason,
        orderStatus,
        shippingAddress,
      ];
}
