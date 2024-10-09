import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String date;
  final String description;
  final String amount;

  const TransactionItem({
    Key? key,
    required this.date,
    required this.description,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
