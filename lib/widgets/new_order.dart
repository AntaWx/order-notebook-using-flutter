import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewOrder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final nameOrder = TextEditingController();

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
              controller: name,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'order'),
              controller: nameOrder,
            ),
            TextButton(
                onPressed: () {
                  print(name);
                  print(nameOrder);
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
