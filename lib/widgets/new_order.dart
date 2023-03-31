import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewOrder extends StatefulWidget {
  final Function addOrd;

  NewOrder({super.key, required this.addOrd});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final nameController = TextEditingController();

  final nameOrderController = TextEditingController();

  final priceController = TextEditingController();

  final amountController = TextEditingController();

  void submitOrder() {
    final submitName = nameController.text;
    final submitNameOrder = nameOrderController.text;
    final submitPrice = double.parse(priceController.text);
    final submitAmount = int.parse(amountController.text);

    if (submitName.isEmpty ||
        submitNameOrder.isEmpty ||
        submitAmount <= 0 ||
        submitPrice < 0) {
      return;
    }

    widget.addOrd(submitName, submitNameOrder, submitAmount, submitPrice);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'nama'),
              controller: nameController,
              onSubmitted: (_) => submitOrder(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'pesanan'),
              controller: nameOrderController,
              minLines: 1,
              maxLines: 5,
              onSubmitted: (_) => submitOrder(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'jumlah'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitOrder(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'harga'),
              controller: priceController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitOrder(),
            ),
            TextButton(
                onPressed: () {
                  submitOrder;
                },
                child: const Text(
                  'add order',
                  style: TextStyle(color: Colors.amber),
                ))
          ],
        ),
      ),
    );
  }
}
