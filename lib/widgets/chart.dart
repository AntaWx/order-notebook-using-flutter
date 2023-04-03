import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_notebook_order/models/order.dart';
import 'package:simple_notebook_order/widgets/chart_bar.dart';

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

      return {
        'days': DateFormat.E().format(weekDays).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return daysPriceOrder.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  const Chart({super.key, required this.dayDataOrder});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...daysPriceOrder.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  days: data['days'] as String,
                  spendingAmount: data['amount'] as double,
                  spendingPctAmount: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
