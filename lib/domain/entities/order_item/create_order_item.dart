import 'package:equatable/equatable.dart';

class CreateOrderItem extends Equatable {
  String? orderID;
  String? productID;
  int? quantity;
  double? unitPrice;
  String? status;

  CreateOrderItem({
    this.orderID,
    this.productID,
    this.quantity,
    this.unitPrice,
    this.status,
  });

  @override
  List<Object?> get props => [
        orderID,
        productID,
        quantity,
        unitPrice,
        status,
      ];
}
