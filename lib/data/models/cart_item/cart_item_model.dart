import '../../../domain/entities.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required String id,
    required String productId,
    required String name,
    required double price,
    required int quantity,
    required String imageUrl,
    String? color,
  }) : super(
          id: id,
          productId: productId,
          name: name,
          price: price,
          quantity: quantity,
          imageUrl: imageUrl,
          color: color,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'color': color,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      productId: json['productId'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
      color: json['color'],
    );
  }

  // Từ entity chuyển sang model
  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      id: cartItem.id,
      productId: cartItem.productId,
      name: cartItem.name,
      price: cartItem.price,
      quantity: cartItem.quantity,
      imageUrl: cartItem.imageUrl,
      color: cartItem.color,
    );
  }

  // Chuyển từ model về entity
  CartItem toEntity() {
    return CartItem(
      id: id,
      productId: productId,
      name: name,
      price: price,
      quantity: quantity,
      imageUrl: imageUrl,
      color: color,
    );
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
    String? color,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
    );
  }
}
