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
  static num totalBudget = 0;
  static bool categoryFlag = false;
  final List<ExpenseModel> _expensesList = [];
  final List<BudgetModel> _budgetList = [];
  List<ExpenseModel> get getExpensesList => _expensesList;
  List<BudgetModel> get getBudgetList => _budgetList;

  // fetch all the expenses data
  //TODO: I have need to fetch expenses according to the month
  //TODO: there will be option to see expenses history there user will see previous history
  Future<void> getAllExpenses() async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    _expensesList.clear();
    categoryFlag = false;
    totalSpent = 0;
    List<Map<String, dynamic>> mapExpenses = await database.query(ExpenseDbHelper.TABLE_NAME);
    mapExpenses.forEach((expense) {
      _expensesList.add(ExpenseModel.fromMap(expense));
      totalSpent = totalSpent + expense[ExpenseDbHelper.EXPENSES_COLUMN];
    },);
    await getAllBudgets();
  }

  // start of budget fetching
  Future<void> getAllBudgets() async{
    final DateTime now = DateTime.now();
    final startOfMonth = DateTime(
        now.year,
        now.month,
        1
    ).toIso8601String();
    final startOfNextMonth = DateTime(
      now.year,
      now.month + 1,
      1
    ).toIso8601String();
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    _budgetList.clear();
    totalBudget = 0;
    List<Map<String, dynamic>> mapBudgets = await database.query(
        ExpenseDbHelper.BUDGET_TABLE,
        where: '''(${ExpenseDbHelper.BUDGET_INIT_DATE_TIME_COLUMN} >= ?)
      and (${ExpenseDbHelper.BUDGET_INIT_DATE_TIME_COLUMN} < ?)
      ''',
        whereArgs: [startOfMonth, startOfNextMonth]
    );
    mapBudgets.forEach((budget) {
      _budgetList.add(BudgetModel.fromMap(budget));
      totalBudget = totalBudget + budget[ExpenseDbHelper.BUDGET_COLUMN];
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
    await getAllBudgets();
  }

  // update budget event
  Future<void> updateBudget(BudgetModel budget) async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    await database.update(ExpenseDbHelper.BUDGET_TABLE, {
      ExpenseDbHelper.BUDGET_COLUMN: budget.budget,
      ExpenseDbHelper.BUDGET_INIT_DATE_TIME_COLUMN: budget.DateTime
    }, where: "${ExpenseDbHelper.ID_COLUMN} == ?", whereArgs: [budget.id]);
    await getAllBudgets();
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

  // delete expenses event
  Future<void> deleteExpense(int id) async{
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    await database.delete(ExpenseDbHelper.TABLE_NAME,
        where: "${ExpenseDbHelper.ID_COLUMN}  == ?", whereArgs: [id]);
    await getAllExpenses();
  }

  // search by category
  Future<void> getExpenseByCategory(String category) async{
    if(category.contains("All")){
      getAllExpenses();
      return ;
    }
    Database database = await ExpenseDbHelper.getInstance.getExpenseDB();
    _expensesList.clear();
    categoryFlag = true;
    List<Map<String, dynamic>> mapCategoryList = await database.query(ExpenseDbHelper.TABLE_NAME,
        where: "${ExpenseDbHelper.CATEGORY_COLUMN} == ?", whereArgs: [category]);
    mapCategoryList.forEach((expense) {
      _expensesList.add(ExpenseModel.fromMap(expense));
    },);
    notifyListeners();
  }
}