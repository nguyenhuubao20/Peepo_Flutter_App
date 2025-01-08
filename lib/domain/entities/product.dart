import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final DateTime? createdDate;
  final DateTime? modifiedDate;
  final String? createdBy;
  final String? modifiedBy;
  final String? status;
  final String? baseModelID;
  final String? productName;
  final int? stock;
  final String? description;
  final String? img;
  final double? finalPrice;

  Product({
    this.id,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.baseModelID,
    this.productName,
    this.stock,
    this.description,
    this.img,
    this.finalPrice,
  });

  @override
  List<Object?> get props => [
        id,
        createdDate,
        modifiedDate,
        createdBy,
        modifiedBy,
        status,
        baseModelID,
        productName,
        stock,
        description,
        img,
        finalPrice,
      ];
}
