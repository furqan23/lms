import 'package:flutter/material.dart';

import '../../model/cart_model.dart';

class CartScreen extends StatelessWidget {
  final List<CartModel> cartList;

  CartScreen({required this.cartList});

  @override
  Widget build(BuildContext context) {
    // Calculate the total balance by summing up the prices of all items in the cart
    double totalBalance = cartList.fold(0.0, (double sum, CartModel cartItem) {
      return sum + cartItem.price;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final cartItem = cartList[index];
                return ListTile(
                  title: Text(cartItem.courseTitle),
                  subtitle:
                      Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
                  // Add any other information you want to display for each item
                );
              },
            ),
          ),
          // Display the total balance at the bottom of the screen
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Amount: \$${totalBalance.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
