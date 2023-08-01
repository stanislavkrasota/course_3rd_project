import 'package:course_3rd_project/widgets/expanses_list/expenses_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expanses, required this.onRemoveExpense});

  final List<Expense> expanses;

  final Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(expanses[index]),
        onDismissed: (direction) {
          onRemoveExpense(expanses[index]);
        },
        child: ExpenseItem(
          expanses[index],
        ),
      ),
      itemCount: expanses.length,
    );
  }
}
