import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseDbHelper {

  ExpenseDbHelper._();
  static final ExpenseDbHelper getInstance = ExpenseDbHelper._();
  static final String TABLE_NAME = "expense";
  static final String BUDGET_TABLE = "budget";
  static final String DB_NAME = "expenses.db";
  static final String ID_COLUMN = "id";
  static final String EXPENSES_COLUMN = "expenses";
  static final String TITLE_COLUMN  = "title";
  static final String CATEGORY_COLUMN = "category";
  static final String BUDGET_COLUMN = "budget";
  static final String BUDGET_INIT_DATE_TIME_COLUMN = "initDate";
  Database ? db;

  Future<Database> getExpenseDB() async{
    if(db != null){
      return db!;
    } else {
      db = await _getDB();
      return db!;
    }
  }

  Future<Database> _getDB() async{
    Directory databasePath = await getApplicationDocumentsDirectory();
    String path = join(databasePath.path, DB_NAME);
    return db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          create table $TABLE_NAME(
          $ID_COLUMN INTEGER PRIMARY KEY AUTOINCREMENT,
          $TITLE_COLUMN text not null,
          $EXPENSES_COLUMN INTEGER not null,
          $CATEGORY_COLUMN text not null,
          );
          
          create table $BUDGET_TABLE(
          $ID_COLUMN INTEGER PRIMARY KEY AUTOINCREMENT,
          $BUDGET_COLUMN INTEGER not null,
          $BUDGET_INIT_DATE_TIME_COLUMN text not null
          )
          '''
        );
      },
      version: 1
    );
  }

}