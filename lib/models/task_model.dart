import 'package:dashboard/database/task_db_helper.dart';

class TaskModel {
  const TaskModel({required this.title, required this.subTitle,
    this.totalTask, this.completedTask, this.completed, this.dateTime
  });
  final int ? completedTask;
  final bool ? completed;
  final int ? totalTask;
  final String title;
  final String subTitle;
  final String ? dateTime;

  // factory constructor to convert map to TaskModel
  factory TaskModel.fromMap(Map<String, dynamic> map){
    return TaskModel(
      title: map[TaskDbHelper.TITLE_COLUMN],
      subTitle: map[TaskDbHelper.SUBTITLE_COLUMN],
      totalTask: map[TaskDbHelper.TOTAL_TASK_COLUMN],
      completedTask: map[TaskDbHelper.TOTAL_TASK_COMPLETED_COLUMN],
      completed: map[TaskDbHelper.COMPLETED_OR_NOT_COLUMN],
      dateTime: map[TaskDbHelper.DATE_TIME_COLUMN],
    );
  }
}