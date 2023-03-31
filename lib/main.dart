import 'package:flutter/material.dart';
import 'package:simple_notebook_order/models/order.dart';
import 'package:simple_notebook_order/widgets/order_list.dart';

import 'util/generate_util/add_new_order.dart';
import 'widgets/new_order.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Order> _orderList = [
    Order(
        id: 21,
        name: 'gus anta',
        order: 'canang ceper gede',
        price: 2,
        amount: 2,
        date: DateTime.now()),
    Order(
        id: 21,
        name: 'bayu',
        order: 'canang sari gede',
        price: 7,
        amount: 3,
        date: DateTime.now()),
  ];

  void _newOrderList(
      String ordName, String ordOrder, int amountOrder, double ordPrice) {
    final newOrder = Order(
        id: RandomIntId().gusantaIdGen(),
        name: ordName,
        order: ordOrder,
        price: ordPrice,
        amount: amountOrder,
        date: DateTime.now());

    setState(() {
      _orderList.add(newOrder);
    });
  }

  void _openAddNewOrder(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewOrder(addOrd: _newOrderList);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Notebook'),
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
                onPressed: () => _openAddNewOrder(context),
                icon: const Icon(
                  Icons.add,
                ))
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: const Card(
                elevation: 5,
                color: Colors.amber,
                child: Text(
                  'CHART!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            OrderList(orders: _orderList)
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () => _openAddNewOrder(context),
          child:  const Icon(Icons.add),
        ),
    );
  }
}
