import '../../../domain/entities.dart';

class ProductModel extends Product {
  ProductModel({
    String? id,
    DateTime? createdDate,
    DateTime? modifiedDate,
    String? createdBy,
    String? modifiedBy,
    String? status,
    String? baseModelID,
    String? productName,
    int? stock,
    String? description,
    String? img,
    double? finalPrice,
  }) : super(
          id: id,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          createdBy: createdBy,
          modifiedBy: modifiedBy,
          status: status,
          baseModelID: baseModelID,
          productName: productName,
          stock: stock,
          description: description,
          img: img,
          finalPrice: finalPrice,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      createdDate: DateTime.parse(json['createdDate']),
      modifiedDate: DateTime.parse(json['modifiedDate']),
      createdBy: json['createdBy'],
      modifiedBy: json['modifiedBy'],
      status: json['status'],
      baseModelID: json['baseModelID'],
      productName: json['productName'],
      stock: json['stock'],
      description: json['description'],
      img: json['img'],
      finalPrice: json['finalPrice'],
    );
  }

  factory ProductModel.toJson(Product product) {
    return ProductModel(
      id: product.id,
      createdDate: product.createdDate,
      modifiedDate: product.modifiedDate,
      createdBy: product.createdBy,
      modifiedBy: product.modifiedBy,
      status: product.status,
      baseModelID: product.baseModelID,
      productName: product.productName,
      stock: product.stock,
      description: product.description,
      img: product.img,
      finalPrice: product.finalPrice,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      createdDate: createdDate,
      modifiedDate: modifiedDate,
      createdBy: createdBy,
      modifiedBy: modifiedBy,
      status: status,
      baseModelID: baseModelID,
      productName: productName,
      stock: stock,
      description: description,
      img: img,
      finalPrice: finalPrice,
    );
  }

  static Product fromEntity(Product product) {
    return Product(
      id: product.id,
      createdDate: product.createdDate,
      modifiedDate: product.modifiedDate,
      createdBy: product.createdBy,
      modifiedBy: product.modifiedBy,
      status: product.status,
      baseModelID: product.baseModelID,
      productName: product.productName,
      stock: product.stock,
      description: product.description,
      img: product.img,
      finalPrice: product.finalPrice,
    );
  }
}
