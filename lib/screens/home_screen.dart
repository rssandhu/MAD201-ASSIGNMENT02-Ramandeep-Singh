/// Course: MAD201 - Assignment 02
/// Name: Ramandeep Singh
/// Student ID: A00194321
/// HomeScreen: Styled list of expenses and navigation.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import '../widgets/expense_card.dart';
import 'add_expense_screen.dart';
import 'expense_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [];

  void _navigateToAddExpense() async {
    final newExpense = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );
    if (newExpense != null && newExpense is Expense) {
      setState(() => _expenses.add(newExpense));
    }
  }

  void _openExpenseDetail(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expense: expense),
      ),
    );
  }

  double get totalExpense => _expenses.fold(0.0, (sum, exp) => sum + exp.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text('Expense Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 3,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.white, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
              child: Card(
                color: Colors.indigo.shade50,
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: const Icon(Icons.savings_rounded, size: 36, color: Colors.indigo),
                  title: const Text("Total Expenses",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  trailing: Text(
                    "\$${totalExpense.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.indigo),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _expenses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.folder_open_rounded, size: 54, color: Colors.indigo),
                          SizedBox(height: 20),
                          Text(
                            "No expenses yet!",
                            style: TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 92),
                      itemCount: _expenses.length,
                      itemBuilder: (context, index) => ExpenseCard(
                        expense: _expenses[index],
                        onTap: () => _openExpenseDetail(_expenses[index]),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70, width: 70,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.indigo,
          icon: const Icon(Icons.add, size: 32),
          label: const Text("Add", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: _navigateToAddExpense,
        ),
      ),
    );
  }
}
