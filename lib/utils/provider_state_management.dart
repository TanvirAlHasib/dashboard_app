import 'package:dashboard/database/db_helper.dart';
import 'package:dashboard/models/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class ProviderStateManagement extends ChangeNotifier {

  ProviderStateManagement(){
    getAllData();
  }

  final List<NoteModel> _noteList = [];
  List<NoteModel> get getNoteList => _noteList;

  // fetching data from database
  Future<void> getAllData() async{
    Database database = await DbHelper.getInstance.getDb();
    List<Map<String, dynamic>> notesMap = await database.query(DbHelper.TABLE_NOTE);
    _noteList.clear();
    notesMap.forEach((note){
      _noteList.add(NoteModel.fromMap(note));
    });
    notifyListeners();
  }

  // insert data to the note table
  Future<void> insertNote(NoteModel note) async{
    Database database = await DbHelper.getInstance.getDb();
    database.insert(DbHelper.TABLE_NOTE, {
      DbHelper.TITLE: note.title,
      DbHelper.DESCRIPTION: note.description,
      DbHelper.CATEGORY: note.category.isEmpty ? "N/A" : note.category,
      DbHelper.DATE_TIME : note.dateTime,
    });
    await getAllData();
  }

  // delete data from the map
  Future<void> deleteNote(int id) async{
    Database database = await DbHelper.getInstance.getDb();
    await database.delete(DbHelper.TABLE_NOTE, where: "${DbHelper.ID} == ?", whereArgs: [id]);
    getAllData();
  }

  // update notes
  Future<void> updateNote(NoteModel note) async{
    Database database = await DbHelper.getInstance.getDb();
    database.update(DbHelper.TABLE_NOTE, {
      DbHelper.TITLE: note.title,
      DbHelper.DESCRIPTION: note.description,
      DbHelper.CATEGORY: note.category,
      DbHelper.DATE_TIME: note.dateTime
    }, where: "${DbHelper.ID} == ?", whereArgs: [note.id]);
    getAllData();
  }

  // fetching notes by category
  Future<void> getNoteByCategory(String category) async{
    Database database = await DbHelper.getInstance.getDb();
    _noteList.clear();
    if(category.contains("All Notes")){
      getAllData();
      return;
    }
    List<Map<String, dynamic>> notesByCategory = await database.query(
      DbHelper.TABLE_NOTE,
      where: "${DbHelper.CATEGORY} == ?",
      whereArgs: [category]
    );
    notesByCategory.forEach((note) {
      _noteList.add(NoteModel.fromMap(note));
    },);
    notifyListeners();
  }
}