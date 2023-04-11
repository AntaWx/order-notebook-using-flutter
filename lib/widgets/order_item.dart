import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({
    super.key,
    required this.order,
    required this.deleteOrders,
  });

  final Order order;
  final Function deleteOrders;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  Color? _color;

  @override
  void initState() {
    const availableColor = [
      Colors.red,
      Colors.green,
      Colors.amber,
      Colors.amberAccent
    ];
    _color = availableColor[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      color: Theme.of(context).colorScheme.background,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _color,
          radius: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(7),
                child: FittedBox(
                    child: Text(
                  widget.order.name,
                  style: Theme.of(context).appBarTheme.toolbarTextStyle,
                )),
              ),
            ],
          ),
        ),
        title: Text(
          'Rp ${widget.order.price.toStringAsFixed(3)}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.order.order} ${widget.order.amount}',
              style: Theme.of(context).appBarTheme.toolbarTextStyle,
            ),
            Text(
              DateFormat.yMMMMd().format(widget.order.date),
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
          ],
        ),
        trailing: MediaQuery.of(context).size.height < 500
            ? TextButton(
                onPressed: () => widget.deleteOrders(widget.order.id),
                child: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => widget.deleteOrders(widget.order.id),
              ),
      ),
    );
  }
}
