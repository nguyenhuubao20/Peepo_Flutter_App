import 'package:equatable/equatable.dart';

import '../../entities.dart';

class OrderItemResponse extends Equatable {
  final String? id;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final String? createdBy;
  final String? modifiedBy;
  final String? status;
  final String? orderID;
  final int? quantity;
  final double? unitPrice;
  final Product? product;
  final bool? isReview;

  OrderItemResponse({
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
  });

  List<Object?> get props => [
        id,
        createdDate,
        modifiedDate,
        createdBy,
        modifiedBy,
        status,
        orderID,
        quantity,
        unitPrice,
        product,
        isReview,
      ];
}
