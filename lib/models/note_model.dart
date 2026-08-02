import 'package:dashboard/database/db_helper.dart';

class NoteModel {
  NoteModel({required this.title,
    required this.description, this.category = "",
    required this.dateTime,
    this.id = 1,
  });

  final String category;
  final String dateTime;
  final String title;
  final String description;
  final int id;

  String get Title =>  title;
  String get Description =>  description;
  String get Category =>  category;
  String get Datetime => dateTime;

  factory NoteModel.fromMap(Map<String, dynamic> map){
    return NoteModel(
      title: map[DbHelper.TITLE],
      description: map[DbHelper.DESCRIPTION],
      category: map[DbHelper.CATEGORY],
      dateTime: map[DbHelper.DATE_TIME],
      id:  map[DbHelper.ID]
    );
  }

}