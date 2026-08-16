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
  static int completedTask = 0;

  // fetch all task function
  Future<void> getAllTask() async{
    Database database = await TaskDbHelper.getInstance.getTaskDB();
    _taskList.clear();
    completedTask = 0;
    List<Map<String, dynamic>> mapTask = await database.query(TaskDbHelper.TASK_DB_TABLE_NAME);
    mapTask.forEach((task) {
      _taskList.add(TaskModel.fromMap(task));
      if(task[TaskDbHelper.COMPLETED_OR_NOT_COLUMN] == 1){
        completedTask = completedTask + 1;
      }
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
    });
    await getAllTask();
  }

  //update task function
  Future<void> updateTask(TaskModel task) async{
    Database database = await TaskDbHelper.getInstance.getTaskDB();
    await database.update(TaskDbHelper.TASK_DB_TABLE_NAME, {
      TaskDbHelper.TITLE_COLUMN: task.title,
      TaskDbHelper.SUBTITLE_COLUMN: task.subTitle,
      TaskDbHelper.DATE_TIME_COLUMN: task.dateTime
    }, where: "${TaskDbHelper.ID_COLUMN} == ?", whereArgs: [task.taskId]);

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

  // delete selected task by id
  Future<void> deleteTask(int id) async{
    Database database = await TaskDbHelper.getInstance.getTaskDB();
    await database.delete(TaskDbHelper.TASK_DB_TABLE_NAME,
        where: "${TaskDbHelper.ID_COLUMN} == ?", whereArgs: [id]);
    await getAllTask();
  }
}