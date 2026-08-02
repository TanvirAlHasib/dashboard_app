import 'package:dashboard/database/db_helper.dart';
import 'package:dashboard/models/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ProviderStateManagement extends ChangeNotifier {

  static late final List<NoteModel> noteList;

  // fetching data from database
  Future<void> getAllData() async{
    Database database = await DbHelper.getInstance.getDb();
    List<Map<String, dynamic>> notesMap = await database.query(DbHelper.TABLE_NOTE);
    notesMap.map((note){
      noteList.add(NoteModel.fromMap(note));
    });
    notifyListeners();
  }

  // insert data to the note table
  Future<void> insertNote(NoteModel note) async{
    Database database = await DbHelper.getInstance.getDb();
    database.insert(DbHelper.TABLE_NOTE, {
      DbHelper.TITLE: note.title,
      DbHelper.DESCRIPTION: note.description,
      DbHelper.CATEGORY: note.category.isEmpty ? "All Notes" : note.category,
      DbHelper.DATE_TIME : note.dateTime ?? DateTime.now().toLocal().toString(),
    });
    notifyListeners();
  }

}