import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  final List<Order> orders;

  const OrderList({required this.orders, super.key});

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
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  margin: const EdgeInsets.all(7),
                  color: Theme.of(context).colorScheme.primary,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Rp ${orders[index].price.toStringAsFixed(3)}',
                          style: Theme.of(context).appBarTheme.toolbarTextStyle,
                          maxLines: 1,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            orders[index].name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '${orders[index].order} ${orders[index].amount}',
                            style:
                                Theme.of(context).appBarTheme.toolbarTextStyle,
                          ),
                          Text(
                            DateFormat.yMMMEd().format(orders[index].date),
                            style:
                                Theme.of(context).appBarTheme.toolbarTextStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
