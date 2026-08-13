import 'package:dashboard/database/expense_db_helper.dart';
import 'package:dashboard/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseProvider extends ChangeNotifier {

  ExpenseProvider() {
    getAllExpenses();
  }

  final List<ExpenseModel> expensesList = [];
  List<ExpenseModel> get getExpensesList => expensesList;

  Future<void> getAllExpenses() async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    expensesList.clear();
    List<Map<String, dynamic>> mapExpenses = await database.query(ExpenseDbHelper.TABLE_NAME);
    mapExpenses.forEach((expense) {
      expensesList.add(ExpenseModel.fromMap(expense));
    },);
    notifyListeners();
  }
}