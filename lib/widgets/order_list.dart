import 'package:flutter/material.dart';
import '../models/order.dart';
import 'package:intl/intl.dart';

class OrderList extends StatelessWidget {
  final List<Order> orders;

  const OrderList({required this.orders, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: orders.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, index) {
          return Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: const EdgeInsets.all(7),
            color: Colors.amber,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  padding: const EdgeInsets.all(10),  
                  child: Text(
                    'Rp ${orders[index].price.toStringAsFixed(3)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    maxLines: 1,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      orders[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      '${orders[index].order} ${orders[index].amount}',
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat.yMMMEd().format(orders[index].date),
                      style: const TextStyle(color: Colors.black87),
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
