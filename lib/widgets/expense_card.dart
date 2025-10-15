
/// Course: MAD201 - Assignment 02
/// Name: Ramandeep Singh
/// Student ID: A00194321
/// Attractive Card widget for a single expense.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMEd().format(expense.date);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        tileColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.12),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.14),
          child: const Icon(Icons.receipt_long, color: Colors.indigo),
        ),
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          '${expense.description}\n$formattedDate',
          style: const TextStyle(fontSize: 14),
        ),
        trailing: Text(
          "\$${expense.amount.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.indigo),
        ),
        onTap: onTap,
      ),
    );
  }
}
