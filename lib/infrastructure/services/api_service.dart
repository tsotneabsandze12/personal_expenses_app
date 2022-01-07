import 'dart:convert';
import 'package:http/http.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';

class ApiService {
  static String baseUri = 'http://10.0.2.2:8080/';

  static Future<List<Expense>> getExpenses() async {
    var response = await get(Uri.parse(baseUri + 'expenses'));

    if (response.statusCode != 200) {
      throw "Failed to load expenses";
    }

    var body = jsonDecode(response.body);
    List<Expense> expenses = [];

    body.forEach((e) {
      Expense expense = Expense.fromJson(e);

      expenses.add(expense);
    });

    return expenses;
  }

  static Future<Expense> getExpenseById(int id) async {
    var response = await get(Uri.parse(baseUri + 'expense/$id'));

    if (response.statusCode != 200) {
      throw "Failed to load expense";
    }

    return Expense.fromJson(jsonDecode(response.body));
  }

  static Future<Expense> addExpense(Expense expense) async {
    var response = await post(
      Uri.parse(baseUri + 'add-expense'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(expense.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to post cases');
    }

    return Expense.fromJson(jsonDecode(response.body));
  }

  static Future<void> deleteExpense(int id) async{
    var response = await delete(Uri.parse(baseUri + 'delete-expense/$id'));

    if(response.statusCode != 200){
      throw "Failed to delete the expense.";
    }
    print("expense deleted successfully");
  }

  static Future<void> updateExpense(Expense expense) async{
    var response = await put(
      Uri.parse(baseUri + 'update-expense'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(expense.toJson()),
    );

    if (response.statusCode != 200) {
      throw 'Failed to update a case';
    }

    print('expense updated successfully');
  }
}