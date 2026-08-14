import 'package:dashboard/database/expense_db_helper.dart';

class ExpenseModel {

  ExpenseModel({ required this.title, required this.expense,
    required this.category, this.id
  });

  final int ? id;
  final String title;
  final int expense;
  final String category;

  factory ExpenseModel.fromMap(Map<String, dynamic> map){
    return ExpenseModel(
      title: map[ExpenseDbHelper.TITLE_COLUMN],
      expense: map[ExpenseDbHelper.EXPENSES_COLUMN],
      category: map[ExpenseDbHelper.CATEGORY_COLUMN],
      id: map[ExpenseDbHelper.ID_COLUMN]
    );
  }

}