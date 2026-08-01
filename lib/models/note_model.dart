import 'package:dashboard/database/db_helper.dart';

class NoteModel {
  NoteModel({required this.title, required this.description, this.category = "", this.dateTime});

  final String category;
  final DateTime ? dateTime;
  final String title;
  final String description;

  String get Title =>  title;
  String get Description =>  description;
  String get Category =>  category;
  DateTime get Datetime => dateTime!;

  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
      title: map[DbHelper.TITLE],
      description: map[DbHelper.DESCRIPTION],
      category: map[DbHelper.CATEGORY],
      dateTime: map[DbHelper.DATE_TIME]
    );
  }

}