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
}