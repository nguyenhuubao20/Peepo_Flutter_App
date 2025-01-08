import '../../../domain/entities/order_item/create_order_item.dart';

class CreateOrderItemModel extends CreateOrderItem {
  CreateOrderItemModel({
    String? orderID,
    String? productID,
    int? quantity,
    double? unitPrice,
    String? status,
  }) : super(
          orderID: orderID,
          productID: productID,
          quantity: quantity,
          unitPrice: unitPrice,
          status: status,
        );

  factory CreateOrderItemModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderItemModel(
      orderID: json['orderID'],
      productID: json['productID'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderID': orderID,
      'productID': productID,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'status': status,
    };
  }

  CreateOrderItem toEntity() {
    return CreateOrderItem(
      orderID: orderID,
      productID: productID,
      quantity: quantity,
      unitPrice: unitPrice,
      status: status,
    );
  }

  static CreateOrderItemModel fromEntity(CreateOrderItem entity) {
    return CreateOrderItemModel(
      orderID: entity.orderID,
      productID: entity.productID,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
      status: entity.status,
    );
  }
}
