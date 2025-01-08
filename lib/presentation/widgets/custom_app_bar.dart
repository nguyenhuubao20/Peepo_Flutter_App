import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/presentation/cubits/cart_count_cubit.dart';

import '../../app_router.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../cubits/cart_count_state.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onCartPressed;
  final Future<int> Function()? getCartCount;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.onNotificationPressed,
    this.onSearchPressed,
    this.onCartPressed,
    this.getCartCount,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int cartCount = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCartCount();
  }

  Future<void> _loadCartCount() async {
    context.read<CartCountCubit>().loadCartCount();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddToCartBloc, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartSuccessState) {
              context.read<CartCountCubit>().loadCartCount();
            }
          },
        ),
      ],
      child: BlocBuilder<CartCountCubit, CartCountState>(
        builder: (context, state) {
          if (state is CartCountLoadedState) {
            cartCount = state.count;
          }
          return _buildAppbar();
        },
      ),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      leading: widget.onBackPressed != null
          ? IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
              onPressed:
                  widget.onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: Colors.black87,
            size: 24,
          ),
          onPressed: widget.onNotificationPressed ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No new notifications')),
                );
              },
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black87,
                size: 24,
              ),
              onPressed:
                  widget.onCartPressed ?? () => AppRouter.navigateToCart(),
            ),
            if (cartCount > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$cartCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
