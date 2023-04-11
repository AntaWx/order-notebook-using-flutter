import 'package:flutter/material.dart';
import '../models/order.dart';

import './order_item.dart';

class OrderList extends StatelessWidget {
  final List<Order> orders;
  final Function deleteOrders;

  const OrderList(
      {required this.orders, super.key, required this.deleteOrders});

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(
              children: [
                Text(
                  'NO ORDERS',
                  style: Theme.of(context).accentTextTheme.titleLarge,
                ),
                Container(
                  height: constraint.maxHeight * 0.69,
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Image.asset(
                      'assets/images/waiting_image-removebg-preview.png'),
                )
              ],
            );
          })
        : ListView(
            children: orders
                .map((e) => OrderItem(key: ValueKey(e.id),order: e, deleteOrders: deleteOrders))
                .toList(),
          );
  }
}
