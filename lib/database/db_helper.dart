import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  //private constructor to make singleton instance
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();
  static const String TABLE_NOTE = "notes";
  static final String ID = "id";
  static final String TITLE = "title";
  static final String DESCRIPTION = "decription";
  static final String DATE_TIME = "date_time";
  static final String CATEGORY = "category";
  Database? db;

  // checking do I have database or not
  Future<Database> getDb() async{
    if(db != null){
      return db!;
    } else{
      db = await openDB();
      return db!;
    }
  }

  //creating database if there is no database
  Future<Database> openDB() async{
    Directory getDirectory = await getApplicationDocumentsDirectory();
    String path = join(getDirectory.path, "noteDB");
    return openDatabase(
      path,
      onCreate: (db, version) async {
        return await db.execute('''CREATE TABLE $TABLE_NOTE(
      $ID INTEGER PRIMARY KEY AUTOINCREMENT,
      $TITLE TEXT NOT NULL,
      $DESCRIPTION TEXT NOT NULL,
      $CATEGORY TEXT DEFAULT '',
      $DATE_TIME TEXT)'''
        );
      },
      version: 1
    );
  }

}