import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peefo/presentation/screens/home/home_screen.dart';
import 'package:peefo/presentation/screens/login/login_screen.dart';
import 'package:peefo/presentation/screens/order/order_history_screen.dart';
import 'package:peefo/presentation/screens/order/order_success_screen.dart';
import 'package:peefo/presentation/screens/product/product_detail_screen.dart';
import 'package:peefo/presentation/screens/product/product_search_screen.dart';

import 'presentation/screens/cart/cart_screen.dart';
import 'presentation/screens/order/order_preview_screen.dart';
import 'presentation/widgets/bottom_navigation.dart';

class AppRouter {
  static const String routeLogin = '/login';
  static const String routeHome = '/home';
  static const String routeProductDetail = '/product-detail/:id';
  static const String routeSettings = '/settings';
  static const String routeNotifications = '/notifications';
  static const String routeCart = '/cart';
  static const String orderPreview = '/order-preview';
  static const String orderSuccess = '/order-success';
  static const String orderHistory = '/order-history';
  static const String productSearch = '/product-search';

  static List<GetPage> get routes => [
        GetPage(
          name: routeLogin,
          page: () => const LoginScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: routeHome,
          page: () => BottomNavigation(child: HomeScreen()),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: routeProductDetail,
          page: () => ProductDetailScreen(
            productId: Get.parameters['id'] ?? '',
          ),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 1),
        ),
        GetPage(
          name: routeCart,
          page: () => CartScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: orderPreview,
          page: () => OrderPreviewScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: orderSuccess,
          page: () => OrderSuccessScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: orderHistory,
          page: () => OrderHistoryScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: productSearch,
          page: () => ProductSearchScreen(),
          transition: Transition.cupertino,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: routeSettings,
          page: () => const Scaffold(
            body: Center(child: Text('Settings Screen')),
          ),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 300),
        ),
      ];

  static void navigateToHome() {
    Get.toNamed(routeHome);
  }

  static void navigateToProductDetail(String productId) {
    Get.toNamed(routeProductDetail.replaceFirst(':id', productId));
  }

  static void navigateToLogin() {
    Get.offNamed(routeLogin);
  }

  static void navigateToCart() {
    Get.toNamed(routeCart);
  }

  static void navigateToSettings() {
    Get.toNamed(routeSettings);
  }

  static void navigateToOrderPreview() {
    Get.toNamed(orderPreview);
  }

  static void navigateToOrderSuccess() {
    Get.toNamed(orderSuccess);
  }

  static void popUntilHome() {
    Get.toNamed(routeHome);
  }

  static void navigateToOrderHistory() {
    Get.toNamed(orderHistory);
  }

  static void navigateToProductSearch() {
    Get.toNamed(productSearch);
  }
}
