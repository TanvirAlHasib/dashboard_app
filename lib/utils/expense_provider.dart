import 'package:dashboard/database/expense_db_helper.dart';
import 'package:dashboard/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseProvider extends ChangeNotifier {

  ExpenseProvider() {
    getAllExpenses();
  }

  static num totalSpent = 0;
  final List<ExpenseModel> _expensesList = [];
  List<ExpenseModel> get getExpensesList => _expensesList;

  Future<void> getAllExpenses() async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    _expensesList.clear();
    totalSpent = 0;
    List<Map<String, dynamic>> mapExpenses = await database.query(ExpenseDbHelper.TABLE_NAME);
    mapExpenses.forEach((expense) {
      _expensesList.add(ExpenseModel.fromMap(expense));
      totalSpent = totalSpent + expense[ExpenseDbHelper.EXPENSES_COLUMN];
    },);
    notifyListeners();
  }
}