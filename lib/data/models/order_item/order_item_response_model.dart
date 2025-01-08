import 'package:peefo/domain/entities/order_item/order_item_response.dart';

import '../product/product_model.dart';

class OrderItemResponseModel extends OrderItemResponse {
  String? id;
  DateTime? createdDate;
  DateTime? modifiedDate;
  String? createdBy;
  String? modifiedBy;
  String? status;
  String? orderID;
  int? quantity;
  double? unitPrice;
  ProductModel? product;
  bool? isReview;

  OrderItemResponseModel({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.orderID,
    this.quantity,
    this.unitPrice,
    this.product,
    this.isReview,
  }) : super(
          id: id,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          createdBy: createdBy,
          modifiedBy: modifiedBy,
          status: status,
          orderID: orderID,
          quantity: quantity,
          unitPrice: unitPrice,
          product: product,
          isReview: isReview,
        );

  factory OrderItemResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderItemResponseModel(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      modifiedDate: DateTime.parse(json['modifiedDate']),
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      status: json['status'],
      orderID: json['orderID'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
      product: ProductModel.fromJson(json['product']),
      isReview: json['isReview'],
    );
  }
}
