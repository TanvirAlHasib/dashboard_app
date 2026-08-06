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

  Future<void> getAllTask() async{
    Database database = await TaskDbHelper.getInstance.getTaskDB();
    _taskList.clear();
    List<Map<String, dynamic>> mapTask = await database.query(TaskDbHelper.TASK_DB_TABLE_NAME);
    mapTask.forEach((task) {
      _taskList.add(TaskModel.fromMap(task));
    },);
    notifyListeners();
  }
}