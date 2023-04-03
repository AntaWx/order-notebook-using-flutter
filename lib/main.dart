import 'package:flutter/material.dart';
import 'package:simple_notebook_order/models/order.dart';
import 'package:simple_notebook_order/widgets/chart.dart';
import 'package:simple_notebook_order/widgets/order_list.dart';

import 'util/generate_util/add_new_order.dart';
import 'widgets/new_order.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: const Color.fromRGBO(6, 41, 73, 1),
          primary: const Color.fromRGBO(5, 86, 129, 1),
          onBackground: const Color.fromRGBO(222, 245, 255, 1),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 20,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.onBackground)),
        accentTextTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'Alkatra',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground)),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'Alkatra',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                  titleLarge: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.onBackground))
              .titleLarge,
        ),
        primaryTextTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 15,
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.onBackground)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Order> _orderList = [];

  List<Order> get _recentOrder {
    return _orderList.where((ord) {
      return ord.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _newOrderList(String ordName, String ordOrder, int amountOrder,
      double ordPrice, DateTime dateTime) {
    final newOrder = Order(
        id: RandomIntId().gusantaIdGen(),
        name: ordName,
        order: ordOrder,
        price: ordPrice,
        amount: amountOrder,
        date: dateTime);

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

  void _deleteOrder(int id) {
    setState(() {
      _orderList.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Order Notebook'),
        backgroundColor: Theme.of(context).colorScheme.background,
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
            child: Card(
                elevation: 5,
                color: Theme.of(context).colorScheme.primary,
                child: Chart(dayDataOrder: _recentOrder)),
          ),
          OrderList(
            orders: _orderList,
            deleteOrders: _deleteOrder,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => _openAddNewOrder(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
