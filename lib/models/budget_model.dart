import 'package:dashboard/database/expense_db_helper.dart';

class BudgetModel {

  BudgetModel({required this.budget, required this.DateTime, this.id});

  final int budget;
  final String DateTime;
  final int ? id;

  factory BudgetModel.fromMap(Map<String, dynamic> map){
    return BudgetModel(
      budget: map[ExpenseDbHelper.BUDGET_COLUMN],
      DateTime: map[ExpenseDbHelper.BUDGET_INIT_DATE_TIME_COLUMN],
      id: map[ExpenseDbHelper.ID_COLUMN]
    );
  }

}