import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String days;
  final double spendingAmount;
  final double spendingPctAmount;

  const ChartBar(
      {super.key,
      required this.days,
      required this.spendingAmount,
      required this.spendingPctAmount});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('Rp${spendingAmount.toStringAsFixed(3)}'))),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          SizedBox(
            height: constrains.maxHeight * 0.58,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctAmount,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.05,
          ),
          SizedBox(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(child: Text(days)))
        ],
      );
    });
  }
}
