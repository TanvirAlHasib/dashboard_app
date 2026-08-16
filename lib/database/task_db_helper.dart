import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class TaskDbHelper {
  // making singleton database instance to the whole app
  TaskDbHelper._();
  static final TaskDbHelper getInstance = TaskDbHelper._();
  static final String ID_COLUMN = "taskID";
  static final String TITLE_COLUMN = "title";
  static final String SUBTITLE_COLUMN = "subTitle";
  static final String DATE_TIME_COLUMN = "dateTime";
  static final String CATEGORY_COLUMN = "category";
  static final String COMPLETED_OR_NOT_COLUMN = "completed";
  static final String TASK_DB_TABLE_NAME = "task";
  Database? taskDB;

  Future<Database> getTaskDB() async{
    if(taskDB != null){
      return taskDB!;
    } else {
      taskDB = await openTaskDB();
      return taskDB!;
    }
  }

  Future<Database> openTaskDB() async{
    Directory documetPath = await getApplicationDocumentsDirectory();
    String path = join(documetPath.path, "taskDB");
    return taskDB = await openDatabase(
      path,
      onCreate: (db, version) {
      return db.execute(
          '''CREATE TABLE $TASK_DB_TABLE_NAME (
          $ID_COLUMN INTEGER PRIMARY KEY AUTOINCREMENT,
          $TITLE_COLUMN TEXT NOT NULL,
          $SUBTITLE_COLUMN TEXT,
          $DATE_TIME_COLUMN TEXT NOT NULL,
          $CATEGORY_COLUMN TEXT NOT NULL,
          $COMPLETED_OR_NOT_COLUMN INTEGER NOT NULL)
          '''
      );},
      version: 1
    );
  }
}