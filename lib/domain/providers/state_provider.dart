import 'package:flutter/cupertino.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';


class StateProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<Expense> _expensesList = [];

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool val) {
    _isProcessing = val;
    notifyListeners();
  }

  setExpensesList(List<Expense> list, {bool notify = true}) {
    _expensesList = list;
    if (notify) notifyListeners();
  }

  Expense getExpenseByIndex(int index) => _expensesList[index];

  int get listLength => _expensesList.length;
}
