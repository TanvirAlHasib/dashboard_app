import 'package:dashboard/database/expense_db_helper.dart';
import 'package:dashboard/models/budget_model.dart';
import 'package:dashboard/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseProvider extends ChangeNotifier {

  ExpenseProvider() {
    getAllExpenses();
  }

  static num totalSpent = 0;
  final List<ExpenseModel> _expensesList = [];
  final List<BudgetModel> _budgetList = [];
  List<ExpenseModel> get getExpensesList => _expensesList;
  List<BudgetModel> get getBudgetList => _budgetList;

  // fetch all the expenses data
  Future<void> getAllExpenses() async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    _expensesList.clear();
    _budgetList.clear();
    totalSpent = 0;
    List<Map<String, dynamic>> mapExpenses = await database.query(ExpenseDbHelper.TABLE_NAME);

    // start of budget fetching
    final DateTime now = DateTime.now();
    final startOfMonth = DateTime(
      now.year,
      now.month,
      1
    );
    final startOfNextMonth = DateTime(
      now.year,
      now.month + 1,
    );
    List<Map<String, dynamic>> mapBudgets = await database.query(
      ExpenseDbHelper.BUDGET_TABLE,
      where: '''(${ExpenseDbHelper.BUDGET_INIT_DATE_TIME_COLUMN} >= ?)
      and (${ExpenseDbHelper.BUDGET_INIT_DATE_TIME_COLUMN} < ?)
      ''',
      whereArgs: [startOfMonth, startOfNextMonth]
    );
    mapBudgets.forEach((budget) {
      _budgetList.add(BudgetModel.fromMap(budget));
    },);

    //end of budget fetching
    mapExpenses.forEach((expense) {
      _expensesList.add(ExpenseModel.fromMap(expense));
      totalSpent = totalSpent + expense[ExpenseDbHelper.EXPENSES_COLUMN];
    },);
    notifyListeners();
  }

  // insert expenses
  Future<void> insertExpense(ExpenseModel expense) async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    await database.insert(ExpenseDbHelper.TABLE_NAME, {
      ExpenseDbHelper.TITLE_COLUMN : expense.title,
      ExpenseDbHelper.EXPENSES_COLUMN : expense.expense,
      ExpenseDbHelper.CATEGORY_COLUMN : expense.category,
    });
    await getAllExpenses();
  }

  // insert budget
  Future<void> insertBudget(BudgetModel budget) async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    await database.insert(ExpenseDbHelper.BUDGET_TABLE, {
      ExpenseDbHelper.BUDGET_COLUMN : budget.budget,
      ExpenseDbHelper.BUDGET_INIT_DATE_TIME_COLUMN : budget.DateTime,
    },);
    await getAllExpenses();
  }

  // update expenses
  Future<void> updateExpense(ExpenseModel expense) async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    await database.update(ExpenseDbHelper.TABLE_NAME, {
      ExpenseDbHelper.TITLE_COLUMN : expense.title,
      ExpenseDbHelper.EXPENSES_COLUMN : expense.expense,
      ExpenseDbHelper.CATEGORY_COLUMN : expense.category
    }, where: "${ExpenseDbHelper.ID_COLUMN} == ?", whereArgs: [expense.id]);
    await getAllExpenses();
  }
}