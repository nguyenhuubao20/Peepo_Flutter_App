import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';

class ProductBanner extends StatefulWidget {
  const ProductBanner({super.key});

  @override
  State<ProductBanner> createState() => _ProductBannerState();
}

class _ProductBannerState extends State<ProductBanner> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBannerBloc>().add(FetchProductBanner(page: 1));
  }

  Widget _buildLoadingSkeleton() {
    return CarouselSlider.builder(
      itemCount: 3,
      options: CarouselOptions(
        height: 250,
        autoPlay: false,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        viewportFraction: 0.85,
        initialPage: 0,
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: Colors.grey[200],
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 70,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBannerBloc, ProductBannerState>(
      builder: (context, state) {
        if (state is ProductBannerLoading) {
          return _buildLoadingSkeleton();
        } else if (state is ProductBannerLoaded) {
          return CarouselSlider.builder(
            itemCount: state.products.length,
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.easeInOutQuart,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              viewportFraction: 0.85,
              initialPage: 0,
            ),
            itemBuilder: (context, index, realIndex) {
              final product = state.products[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl:
                              product.img ?? "https://via.placeholder.com/150",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                          ),
                          errorWidget: (context, url, error) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade300,
                                size: 50,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Không tải được ảnh',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Thẻ "Best Seller"
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Best Seller",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Tên sản phẩm
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            product.productName ?? "Tên sản phẩm",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is ProductBannerError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade300,
                  size: 50,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Không thể tải sản phẩm',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     context
                //         .read<ProductBannerBloc>()
                //         .add(FetchProductBanner(page: 1));
                //   },
                //   child: const Text('Thử lại'),
                // ),
              ],
            ),
          );
        } else if (state is ProductBannerEmpty) {
          return Center(child: Text('Không có dữ liệu.'));
        } else {
          return Center(child: Text('Trạng thái không xác định.'));
        }
      },
    );
  }
}
