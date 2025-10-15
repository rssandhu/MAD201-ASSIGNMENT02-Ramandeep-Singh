/// Course: MAD201 - Assignment 02
/// Name: Ramandeep Singh
/// Student ID: A00194321
/// AddExpenseScreen: Beautiful form design for adding expenses.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 3),
      lastDate: DateTime(now.year + 3),
      builder: (context, child) => Theme(data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: Colors.indigo,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.indigo.shade700,
        ),
      ), child: child!),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _saveExpense() {
    if (_formKey.currentState?.validate() != true) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please select a date.")));
      return;
    }
    final expense = Expense(
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      description: _descriptionController.text.trim(),
      date: _selectedDate!,
    );
    Navigator.pop(context, expense);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputSpacing = SizedBox(height: 22);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
        child: Card(
          elevation: 9,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                      prefixIcon: Icon(Icons.title),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Enter a title' : null,
                  ),
                  inputSpacing,
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      label: Text("Amount (\$)"),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) return "Enter an amount";
                      final n = double.tryParse(val);
                      if (n == null || n <= 0) return "Enter a valid positive number";
                      return null;
                    },
                  ),
                  inputSpacing,
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                      prefixIcon: Icon(Icons.description),
                    ),
                    minLines: 2,
                    maxLines: 5,
                    validator: (val) =>
                        val == null || val.trim().isEmpty ? "Enter a description" : null,
                  ),
                  inputSpacing,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      _selectedDate == null
                          ? "No date chosen"
                          : DateFormat.yMMMd().format(_selectedDate!),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_today, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _pickDate,
                      label: const Text("Choose Date"),
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _saveExpense,
                      label: const Text("Save Expense"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
