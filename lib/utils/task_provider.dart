import 'package:dashboard/database/task_db_helper.dart';
import 'package:dashboard/models/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class TaskProvider extends ChangeNotifier {

  TaskProvider(){
    getAllTask();
  }

  final List<TaskModel> _taskList = [];
  List<TaskModel> get taskList => _taskList;

  // fetch all task function
  Future<void> getAllTask() async{
    Database database = await TaskDbHelper.getInstance.getTaskDB();
    _taskList.clear();
    List<Map<String, dynamic>> mapTask = await database.query(TaskDbHelper.TASK_DB_TABLE_NAME);
    mapTask.forEach((task) {
      _taskList.add(TaskModel.fromMap(task));
    },);
    notifyListeners();
  }

  // insert task function
  Future<void> insertTask(TaskModel task) async{
    Database database = await TaskDbHelper.getInstance.getTaskDB();
    await database.insert(TaskDbHelper.TASK_DB_TABLE_NAME, {
      TaskDbHelper.TITLE_COLUMN : task.title,
      TaskDbHelper.SUBTITLE_COLUMN : task.subTitle,
      TaskDbHelper.DATE_TIME_COLUMN : task.dateTime,
      TaskDbHelper.COMPLETED_OR_NOT_COLUMN : task.completed,
      TaskDbHelper.TOTAL_TASK_COMPLETED_COLUMN : task.completedTask
    });
    await getAllTask();
  }

  //update the task status
  Future<void> updateStatus(int id, int status) async{
    Database database = await TaskDbHelper.getInstance.getTaskDB();
    await database.update(TaskDbHelper.TASK_DB_TABLE_NAME, {
      TaskDbHelper.COMPLETED_OR_NOT_COLUMN : status,
    }, where: "${TaskDbHelper.ID_COLUMN} == ?", whereArgs: [id]);

    await getAllTask();
  }
}