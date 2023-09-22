import 'package:expense_tracker/data/expenso.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expens_list/expense_list.dart';
import 'package:expense_tracker/models/ExpenseModel.dart';
import 'package:expense_tracker/widgets/addexpense.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  TextStyle style = const TextStyle(
    fontSize: 12,
  );

  void showModelBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => AddExpense(
              addExpense: addData,
            ));
  }

  void addData(ExpenseModel expense) {
    setState(() {
      expenso!.add(expense);
    });
  }

  void removeData(ExpenseModel exp) {
    final index = expenso!.indexOf(exp);
    setState(() {
      expenso!.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 3),
        content: Text('${exp.title} is Deleted'),
        action: SnackBarAction(
          textColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            setState(() {
              expenso!.insert(index, exp);
            });
          },
          label: 'Undo',
        ),
      ),
    );
  }

  Widget contentRender() {
    if (expenso!.isEmpty) {
      return const Expanded(child: Center(child: Text("No Expenses Added")));
    } else {
      return Expanded(
        child: MediaQuery.sizeOf(context).width > 600
            ? Row(
                children: [
                  Expanded(child: Chart(expenses: expenso!)),
                  Expanded(
                    child: ExpenseList(
                      expenselist: expenso!,
                      passer: removeData,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(child: Chart(expenses: expenso!)),
                  Expanded(
                    child: ExpenseList(
                      expenselist: expenso!,
                      passer: removeData,
                    ),
                  ),
                ],
              ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.indigo.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Expenso'),
        actions: [
          IconButton(
            onPressed: showModelBottomSheet,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            contentRender()
          ],
        ),
      ),
    );
  }
}
