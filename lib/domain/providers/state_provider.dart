import 'package:flutter/cupertino.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import 'package:darq/darq.dart';
import 'package:personal_expenses_app/infrastructure/services/api_service.dart';

class StateProvider extends ChangeNotifier {
  bool _isProcessing = true;
  List<Expense> _expensesList = [];
  num _totalExpenses = 0.0;
  String _selectedDateEditBottomSheet = '';
  String _selectedDateInsertBottomSheet = '';

  String get selectedDateEditBottomSheet  => _selectedDateEditBottomSheet ;
  String get selectedDateInsertBottomSheet  => _selectedDateInsertBottomSheet ;
  num get totalExpenses => _totalExpenses;
  bool get isProcessing => _isProcessing;
  int get listLength => _expensesList.length;

  setIsProcessing(bool val) {
    _isProcessing = val;
    notifyListeners();
  }

  setEditSelectedDate(String date,{bool notify = true}){
    _selectedDateEditBottomSheet  = date;
    if (notify) notifyListeners();
  }

  setInsertSelectedDate(String date,{bool notify = true}){
    _selectedDateInsertBottomSheet  = date;
    if (notify) notifyListeners();
  }

  setExpensesList({bool notify = true}) async{
    var apiResponse = await ApiService.getExpenses();
    if(apiResponse.isSuccessful){
      _expensesList = apiResponse.data!;
      if (notify) notifyListeners();
    }
  }

  setTotalExpenses({bool notify = true}) {
    if(_expensesList.isNotEmpty){
      _totalExpenses = _expensesList.sum((x) => x.amount);
      if (notify) notifyListeners();
    }else{
      _totalExpenses = 0;
      if (notify) notifyListeners();
    }
  }

  addExpense(Expense expense, {bool notify = true}) async {
    var apiResponse = await ApiService.addExpense(expense);
    if(apiResponse.isSuccessful){
      _expensesList.add(apiResponse.data!);
      if (notify) notifyListeners();
    }
  }

  deleteExpense(int id, {bool notify = true}) async{
    var apiResponse = await ApiService.deleteExpense(id);
    if(apiResponse.isSuccessful){
      _expensesList.removeWhere((e) => e.id == id);
      if (notify) notifyListeners();
    }

  }

  updateExpense(Expense expense, {bool notify = true}) async {
    var apiResponse = await ApiService.updateExpense(expense);
    if(apiResponse.isSuccessful){
      int idx = _expensesList.indexWhere((e) => e.id == expense.id);
      _expensesList[idx] = expense;
      if (notify) notifyListeners();
    }
  }

  Expense getExpenseByIndex(int index) => _expensesList[index];
}
