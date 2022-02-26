import 'package:flutter_diary_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///db provider class
class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  //creating the getter the database
  Future<Database> get database async {
    //first lets check that we don't already have a db
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      //creating first table
      await db.execute('''
 CREATE TABLE Diary_entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  body TEXT,
  creation_date DATE
  )
''');
    }, version: 1);
  }

//function that will add a new note to our variable
  addNewNote(NoteModel note) async {
    final db = await database;
    db.insert("Diary_entries", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
//function that fetches from our database and returns all the
//elements inside the diary entries table
    Future<dynamic> getNotes() async {
      final db = await database;
      var res = await db.query("Diary_entries");
      if (res.length == 0) {
        return Null;
      } else {
        var resultMap = res.toList();
        return resultMap.isNotEmpty ? resultMap : Null;
      }
    }
  }

