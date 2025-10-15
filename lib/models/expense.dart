/// Course: MAD201 - Assignment 02
/// Name: Ramandeep Singh
/// Student ID: A00194321
/// Description: Expense model representing a single expense record.

class Expense {
  final String title;
  final double amount;
  final String description;
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.description,
    required this.date,
  });
}
