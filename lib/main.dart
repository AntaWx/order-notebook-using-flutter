import 'dart:io';

import 'package:flutter/cupertino.dart';
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
                fontSize: 20 * MediaQuery.textScaleFactorOf(context),
                fontWeight: FontWeight.w200,
                color: Theme.of(context).colorScheme.onBackground)),
        accentTextTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'Alkatra',
                fontSize: 18 * MediaQuery.textScaleFactorOf(context),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground)),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'Alkatra',
              fontSize: 20 * MediaQuery.textScaleFactorOf(context),
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                  titleLarge: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 17 * MediaQuery.textScaleFactorOf(context),
                      color: Theme.of(context).colorScheme.onBackground))
              .titleLarge,
        ),
        primaryTextTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 15 * MediaQuery.textScaleFactorOf(context),
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
  bool? showChart = false;

  List<Order> get _recentOrder {
    return _orderList.where((ord) {
      return ord.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        isScrollControlled: true,
        context: ctx,
        builder: (bCtx) {
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom);
          return SingleChildScrollView(
            child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: NewOrder(addOrd: _newOrderList)),
          );
        });
  }

  void _deleteOrder(int id) {
    setState(() {
      _orderList.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final detectOrientation = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Order Notebook',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _openAddNewOrder(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text('Order Notebook'),
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: [
              IconButton(
                  onPressed: () => _openAddNewOrder(context),
                  icon: const Icon(
                    Icons.add,
                  ))
            ],
          ) as PreferredSizeWidget;
    final orderList = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
      child: OrderList(
        orders: _orderList,
        deleteOrders: _deleteOrder,
      ),
    );
    final body = SafeArea(
      child: ListView(
        children: <Widget>[
          if (detectOrientation)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'show chart',
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
                Switch.adaptive(
                    value: showChart!,
                    onChanged: (val) {
                      showChart == null
                          ? false
                          : setState(() {
                              showChart = val;
                            });
                    })
              ],
            ),
          if (!detectOrientation)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(5),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.2,
              child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  elevation: 5,
                  color: Theme.of(context).colorScheme.primary,
                  child: Chart(dayDataOrder: _recentOrder)),
            ),
          if (!detectOrientation) orderList,
          if (detectOrientation)
            showChart == true
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Card(
                        elevation: 5,
                        color: Theme.of(context).colorScheme.primary,
                        child: Chart(dayDataOrder: _recentOrder)),
                  )
                : orderList
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(child: body)
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () => _openAddNewOrder(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
