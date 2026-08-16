import 'package:dashboard/database/task_db_helper.dart';

class TaskModel {
  const TaskModel({required this.title, required this.subTitle, required this.category,
    this.completed, this.dateTime, this.taskId
  });
  final int ? taskId;
  final int ? completed;
  final String title;
  final String subTitle;
  final String ? dateTime;
  final String category;

  // factory constructor to convert map to TaskModel
  factory TaskModel.fromMap(Map<String, dynamic> map){
    return TaskModel(
      taskId: map[TaskDbHelper.ID_COLUMN],
      title: map[TaskDbHelper.TITLE_COLUMN],
      subTitle: map[TaskDbHelper.SUBTITLE_COLUMN],
      completed: map[TaskDbHelper.COMPLETED_OR_NOT_COLUMN],
      dateTime: map[TaskDbHelper.DATE_TIME_COLUMN],
      category: map[TaskDbHelper.CATEGORY_COLUMN]
    );
  }
}