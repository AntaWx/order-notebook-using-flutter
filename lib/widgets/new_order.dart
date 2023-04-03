import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewOrder extends StatefulWidget {
  final Function addOrd;

  const NewOrder({super.key, required this.addOrd});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final _nameController = TextEditingController();
  final _nameOrderController = TextEditingController();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? userPickedDate;

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          userPickedDate = pickedDate;
        });
      }
    });
  }

  void _submitOrder() {
    final submitName = _nameController.text;
    final submitNameOrder = _nameOrderController.text;
    final submitPrice = double.parse(_priceController.text);
    final submitAmount = int.parse(_amountController.text);

    if (submitName.isEmpty ||
        submitNameOrder.isEmpty ||
        submitAmount <= 0 ||
        submitPrice < 0 ||
        userPickedDate == null) {
      return;
    }

    widget.addOrd(
        submitName, submitNameOrder, submitAmount, submitPrice, userPickedDate);

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
              decoration: const InputDecoration(labelText: 'nama'),
              controller: _nameController,
              onSubmitted: (_) => _submitOrder(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'pesanan'),
              controller: _nameOrderController,
              minLines: 1,
              maxLines: 5,
              onSubmitted: (_) => _submitOrder(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'jumlah'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              minLines: 1,
              maxLines: 5,
              onSubmitted: (_) => _submitOrder(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'harga'),
              controller: _priceController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitOrder(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    userPickedDate == null
                        ? 'No Date Choosen'
                        : DateFormat.yMd().format(userPickedDate!),
                  ),
                ),
                TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  _submitOrder();
                },
                child: Text(
                  'add order',
                  style: Theme.of(context).accentTextTheme.titleLarge,
                ))
          ],
        ),
      ),
    );
  }
}
