import 'dart:convert';
import 'package:http/http.dart';
import 'package:personal_expenses_app/domain/models/expense.dart';
import '../api_response.dart';

class ApiService {
  static String baseUri = 'http://10.0.2.2:8080/';

  static Future<ApiResponse<List<Expense>>> getExpenses() async {
    try {
      var response = await get(Uri.parse(baseUri + 'expenses'));
      if (response.statusCode != 200) {
        return handleException<List<Expense>>(
            statusCode: response.statusCode,message: 'could not fetch expenses');
      }

      var body = jsonDecode(response.body);
      List<Expense> expenses = [];

      body.forEach((e) {
        Expense expense = Expense.fromJson(e);
        expenses.add(expense);
      });

      return ApiResponse<List<Expense>>(
          isSuccessful: true, data: expenses, statusCode: response.statusCode);
    } catch (e) {
      return handleException<List<Expense>>(
        message: e.toString(),
      );
    }
  }

  static Future<ApiResponse<Expense>> getExpenseById(int id) async {
    try {
      var response = await get(Uri.parse(baseUri + 'expense/$id'));

      if (response.statusCode != 200) {
        return handleException<Expense>(
             statusCode: response.statusCode);
      }

      return ApiResponse<Expense>(
          isSuccessful: true,
          data: Expense.fromJson(jsonDecode(response.body)),
          statusCode: response.statusCode);
    } catch (e) {
      return handleException<Expense>(
        message: e.toString(),
      );
    }
  }

  static Future<ApiResponse<Expense>> addExpense(Expense expense) async {
    try{
      var response = await post(
        Uri.parse(baseUri + 'add-expense'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(expense.toJson()),
      );

      if (response.statusCode != 200) {
        return handleException<Expense>(
            statusCode: response.statusCode);
      }

      return ApiResponse<Expense>(
        isSuccessful: true,
        statusCode: response.statusCode,
        data: Expense.fromJson(jsonDecode(response.body)),
      );

    }catch(e){
      return handleException<Expense>(
        message: e.toString(),
      );
    }

  }

  static Future<ApiResponse<void>> deleteExpense(int id) async {
    try{
      var response = await delete(Uri.parse(baseUri + 'delete-expense/$id'));

      if (response.statusCode != 200) {
        return handleException<Expense>(
            statusCode: response.statusCode);
      }
      return ApiResponse<void>(
        isSuccessful: true,
        statusCode: response.statusCode,
      );
    }catch(e){
      return handleException<void>(
        message: e.toString(),
      );
    }

  }

  static Future<ApiResponse<void>> updateExpense(Expense expense) async {
    try{
      var response = await put(
        Uri.parse(baseUri + 'update-expense'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(expense.toJson()),
      );

      if (response.statusCode != 200) {
        return handleException<void>(
            statusCode: response.statusCode);
      }

      return ApiResponse<void>(
        isSuccessful: true,
        statusCode: response.statusCode,
      );

    }catch(e){
      return handleException<void>(
        message: e.toString(),
      );
    }
  }

  static ApiResponse<T> handleException<T>({int? statusCode,String? message}){
    return ApiResponse<T>(
        isSuccessful: false,
        statusCode: statusCode,
        message: message
    );
  }
}

