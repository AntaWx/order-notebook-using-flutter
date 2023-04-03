import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  final List<Order> orders;
  final Function deleteOrders;

  const OrderList(
      {required this.orders, super.key, required this.deleteOrders});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: orders.isEmpty
          ? Column(
              children: [
                Text(
                  'NO ORDERS',
                  style: Theme.of(context).accentTextTheme.titleLarge,
                ),
                Container(
                  height: 350,
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Image.asset(
                      'assets/images/waiting_image-removebg-preview.png'),
                )
              ],
            )
          : ListView.builder(
              itemCount: orders.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  color: Theme.of(context).colorScheme.background,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: FittedBox(
                                child: Text(
                              'Rp ${orders[index].price.toStringAsFixed(3)}',
                              style: Theme.of(context)
                                  .appBarTheme
                                  .toolbarTextStyle,
                            )),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      orders[index].name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${orders[index].order} ${orders[index].amount}',
                          style: Theme.of(context).appBarTheme.toolbarTextStyle,
                        ),
                        Text(
                          DateFormat.yMMMMd().format(orders[index].date),
                          style: Theme.of(context).primaryTextTheme.titleLarge,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () => deleteOrders(orders[index].id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
