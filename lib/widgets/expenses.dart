import 'package:course_3rd_project/enums/expense_category.dart';
import 'package:course_3rd_project/widgets/chart/chart.dart';
import 'package:course_3rd_project/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expanses_list/expanses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registareExpanses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: ExpenseCategory.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 10.99,
      date: DateTime.now(),
      category: ExpenseCategory.leisure,
    ),
  ];

  void _addNewExpenseItem(Expense expense) {
    setState(() {
      _registareExpanses.add(expense);
    });
  }

  void _removeExpenseItem(Expense expense) {
    final expenseIndex = _registareExpanses.indexOf(expense);
    setState(() {
      _registareExpanses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registareExpanses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseModal() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        addNewExpenseItem: _addNewExpenseItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found'),
    );

    if (_registareExpanses.isNotEmpty) {
      mainContent = ExpensesList(
        expanses: _registareExpanses,
        onRemoveExpense: _removeExpenseItem,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseModal,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registareExpanses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registareExpanses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
