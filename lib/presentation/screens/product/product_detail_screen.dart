import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/app_router.dart';

import '../../../domain/entities.dart';
import '../../blocs/blocs.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/notification.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? selectedColor;
  int quantity = 1;
  String imageUrl = '';
  List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow];
  List<String> colorStrings = ['Red', 'Blue', 'Green', 'Yellow'];
  late Product productToCart;

  @override
  void initState() {
    super.initState();
    context
        .read<ProductDetailBloc>()
        .add(FetchProductDetail(id: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product Detail',
        onBackPressed: () => AppRouter.navigateToHome(),
        onCartPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoaded) {
            productToCart = state.product;
            return _buildProductDetail(state);
          } else if (state is ProductDetailError) {
            return _buildError(state);
          } else {
            return _buildLoading(); // Hiển thị giao diện chờ
          }
        },
      ),
      bottomNavigationBar: _buildAddToCartButton(),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300], // Placeholder cho hình ảnh
          ),
          const SizedBox(height: 16),
          Container(
            width: 150,
            height: 20,
            color: Colors.grey[300], // Placeholder cho tên sản phẩm
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            height: 20,
            color: Colors.grey[300], // Placeholder cho giá
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 100,
            color: Colors.grey[200], // Placeholder cho mô tả
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetail(ProductDetailLoaded state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: CachedNetworkImage(
                imageUrl:
                    state.product.img ?? "https://via.placeholder.com/150",
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (state.product.productName?.length ?? 0) > 20
                      ? '${state.product.productName!.substring(0, 20)}...'
                      : state.product.productName ?? "Tên sản phẩm",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$${state.product.finalPrice}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              state.product.description ?? 'Description not available.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Choose Color:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: colors.map((color) {
                int index = colors.indexOf(color); // Tìm chỉ số của màu
                return ChoiceChip(
                  label: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  selected: selectedColor == colorStrings[index],
                  onSelected: (isSelected) {
                    setState(() {
                      selectedColor = isSelected ? colorStrings[index] : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Quantity Selector
            const Text(
              'Quantity:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: quantity > 1
                      ? () {
                          setState(() {
                            quantity--;
                          });
                        }
                      : null,
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(ProductDetailError state) {
    return Center(
      child: Text(
        'Failed to load product details: ${state.message}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, color: Colors.red),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (selectedColor == null) {
            NotificationApp.show(
              context,
              'Please select a color',
              backgroundColor: Colors.red.shade200,
              icon: Icons.error,
            );
            return;
          }

          NotificationApp.show(
            context,
            'Added to cart',
            backgroundColor: Colors.white,
            icon: Icons.shopping_cart,
          );

          context.read<AddToCartBloc>().add(
                AddToCartEvent(
                  CartItem(
                    id: widget.productId,
                    productId: widget.productId,
                    name: productToCart.productName ?? 'Product Name',
                    price: productToCart.finalPrice ?? 0,
                    quantity: quantity,
                    imageUrl: productToCart.img ?? '',
                    color: selectedColor,
                  ),
                ),
              );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Add To Cart',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
