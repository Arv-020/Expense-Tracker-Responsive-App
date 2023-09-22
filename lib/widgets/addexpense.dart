import 'package:expense_tracker/component/showerror.dart';
// import 'package:expense_tracker/data/expenso.dart';
import 'package:expense_tracker/models/ExpenseModel.dart';
// import 'package:expense_tracker/widgets/expense_screen.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.addExpense});
  final Function(ExpenseModel exp) addExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _title = TextEditingController();
  final _price = TextEditingController();
  DateTime? _date;
  Category _selectedcategory = Category.food;

  void _showcalendra() async {
    final now = DateTime.now();
    final datechoosed = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      _date = datechoosed;
    });
  }

  void onTap() {
    final amount = double.tryParse(_price.text);
    final isAmountNotValid = amount == null || amount <= 0;
    if (_title.text.trim().isEmpty) {
      ShowError(context, "Title must be Valid");
      return;
    } else if (isAmountNotValid) {
      ShowError(context, "Amount must be Valid");
      return;
    } else if (_date == null) {
      ShowError(context, "Please select a Date.");
      return;
    }
    widget.addExpense(ExpenseModel(
        title: _title.text,
        price: amount,
        date: _date!,
        category: _selectedcategory));
    Navigator.pop(context);
  }

  void compareData(bool isvalid) {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _title.dispose();
    _price.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                16,
                50,
                16,
                MediaQuery.viewInsetsOf(context).bottom +
                    20), // viewinsets which is important
            child: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth < 600
                  ? Column(
                      children: [
                        TextField(
                          maxLength: 50,
                          controller: _title,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              label: Text('Title'),

                              // hintText: 'Title',
                              prefixIcon: Icon(Icons.title)),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                // expands: true,
                                maxLength: 9,
                                keyboardType: TextInputType.number,
                                controller: _price,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    label: Text('Amount'),
                                    // hintText: 'Amount',
                                    prefixText: '\$'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(_date == null
                                    ? 'No Date Selected'
                                    : formatter.format(_date!)),
                                IconButton(
                                  onPressed: _showcalendra,
                                  icon: const Icon(Icons.calendar_month),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            DropdownButton(
                              alignment: Alignment.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              value: _selectedcategory,
                              items: Category.values
                                  .map((category) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: category,
                                      child: Text(
                                        category.name.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedcategory = value;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // _title.text = '';
                                  // _price.text = '';
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                              onPressed: onTap,
                              child: const Text('Save Expense'),
                            ),
                          ],
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                maxLength: 50,
                                controller: _title,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    label: Text('Title'),

                                    // hintText: 'Title',
                                    prefixIcon: Icon(Icons.title)),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextField(
                                // expands: true,
                                maxLength: 9,
                                keyboardType: TextInputType.number,
                                controller: _price,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    label: Text('Amount'),
                                    // hintText: 'Amount',
                                    prefixText: '\$'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            DropdownButton(
                              alignment: Alignment.center,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              value: _selectedcategory,
                              items: Category.values
                                  .map((category) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: category,
                                      child: Text(
                                        category.name.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      )))
                                  .toList(),
                              onChanged: (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _selectedcategory = value;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(_date == null
                                    ? 'No Date Selected'
                                    : formatter.format(_date!)),
                                IconButton(
                                  onPressed: _showcalendra,
                                  icon: const Icon(Icons.calendar_month),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // _title.text = '';
                                // _price.text = '';
                                Navigator.pop(context);
                              },
                              // style: ElevatedButton.styleFrom(
                              //     fixedSize: const Size(50, 50)),
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                              onPressed: onTap,
                              child: const Text('Save Expense'),
                            ),
                          ],
                        )
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
