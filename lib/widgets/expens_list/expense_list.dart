import 'package:expense_tracker/data/expenso.dart';
import 'package:expense_tracker/models/ExpenseModel.dart';
import 'package:expense_tracker/widgets/expens_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenselist, required this.passer});
  final List<ExpenseModel> expenselist;
  final Function(ExpenseModel exp) passer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenso!.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direct) {
              passer(expenselist[index]);
            },
            key: ValueKey(expenselist[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.4),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              child: const Icon(Icons.delete),
            ),
            child: ExpenseItem(
              expense: expenselist[index],
              remove: passer,
            ),
          );
        });
  }
}
