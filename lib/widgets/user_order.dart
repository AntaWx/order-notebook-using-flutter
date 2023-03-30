import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:simple_notebook_order/widgets/new_order.dart';
import '../widgets/order_list.dart';
import '../models/order.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({super.key});

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  final List<Order> _orderList = [
    Order(
        id: 21,
        name: 'gus anta',
        order: 'canang ceper gede',
        price: 2000,
        amount: 2,
        date: DateTime.now()),
    Order(
        id: 21,
        name: 'bayu',
        order: 'canang sari gede',
        price: 7000,
        amount: 3,
        date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewOrder(),
        OrderList(
          orders: _orderList,
        )
      ],
    );
  }
}
