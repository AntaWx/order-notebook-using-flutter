import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_notebook_order/models/order.dart';

class Chart extends StatelessWidget {
  final List<Order> dayDataOrder;

  List<Map<String, Object>> get daysPriceOrder {
    return List.generate(7, (index) {
      final weekDays = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < dayDataOrder.length; i++) {
        if (dayDataOrder[i].date.day == weekDays.day &&
            dayDataOrder[i].date.month == weekDays.month &&
            dayDataOrder[i].date.year == weekDays.year) {
          totalSum += dayDataOrder[i].price;
        }
      }

      print(DateFormat.E(weekDays));
      print(totalSum);  

      return {'days': DateFormat.E(weekDays), 'amount': totalSum};
    });
  }

  const Chart({super.key, required this.dayDataOrder});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [],
      ),
    );
  }
}
