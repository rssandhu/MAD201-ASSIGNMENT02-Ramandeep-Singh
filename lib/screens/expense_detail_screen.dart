/// Course: MAD201 - Assignment 02
/// Name: Ramandeep Singh
/// Student ID: A00194321
/// Detail screen: Styled read-only view for expense.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd().format(expense.date);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 36),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.indigo)),
                Text(expense.title, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 18),
                Text("Amount:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.indigo)),
                Text("\$${expense.amount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 18),
                Text("Description:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.indigo)),
                Text(expense.description, style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 18),
                Text("Date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.indigo)),
                Text(formattedDate, style: const TextStyle(fontSize: 17)),
                const SizedBox(height: 28),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(context),
                    label: const Text("Back"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
