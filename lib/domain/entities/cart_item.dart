import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String productId;
  final String name;
  final double price;
  late final int quantity;
  final String imageUrl;
  final String? color;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.color,
  });

  double get total => price * quantity;

  @override
  List<Object?> get props =>
      [id, productId, name, price, quantity, imageUrl, color];
}
