import 'package:flutter/material.dart';

void main(List<String> args) {}

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('购物车'));
  }
}
