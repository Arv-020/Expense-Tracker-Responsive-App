import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _uuid = Uuid();

enum Category { food, shoes, entertainment, studies }

const categoryIcon = {
  // new thing
  Category.food: Icons.restaurant,
  Category.shoes: Icons.blind_sharp,
  Category.entertainment: Icons.movie,
  Category.studies: Icons.book,
};

final formatter = DateFormat.yMd();

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.price,
    required this.date,
    required this.category,
  });

  final String id = _uuid.v4();
  final String title;
  final double price;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.fromCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  final Category category;
  final List<ExpenseModel> expenses;

  double get totalPrice {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.price;
    }
    return sum;
  }
}
