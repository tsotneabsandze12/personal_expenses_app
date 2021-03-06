import 'package:flutter/material.dart';
import 'package:personal_expenses_app/domain/providers/state_provider.dart';
import 'package:provider/provider.dart';

AlertDialog deleteDialog(int id, BuildContext context) {
  return AlertDialog(
    title: const Text('Accept?'),
    content: const Text('Do you really want to delete this item?'),
    actions: [
      TextButton(
        onPressed: () async {
          await Provider.of<StateProvider>(context, listen: false)
              .deleteExpense(id, notify: true);
          Navigator.of(context).pop();
        },
        child: const Text('Yes'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('No'),
      ),
    ],
  );
}