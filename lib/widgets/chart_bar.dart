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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            margin: const EdgeInsets.all(3),
            child: FittedBox(
                child: Text('Rp${spendingAmount.toStringAsFixed(3)}'))),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
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
        const SizedBox(
          height: 4,
        ),
        Text(days)
      ],
    );
  }
}
