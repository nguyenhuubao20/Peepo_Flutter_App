import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peefo/presentation/screens/cart/components/cart_failed.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../widgets/custom_app_bar.dart';
import 'components/cart_body.dart';
import 'components/cart_empty.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<bool> selectedItems = [];

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: 'Shopping Cart',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else if (state is CartErrorState) {
            return CartFailed();
          } else if (state is CartLoadedState) {
            final cartItems = state.items;

            if (cartItems.isEmpty) {
              return CartEmpty();
            }

            if (selectedItems.length != cartItems.length) {
              selectedItems = List.generate(cartItems.length, (index) => false);
            }

            return CartBody(cartItems: cartItems);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
