import 'package:flutter_diary_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///db provider class
class DatabaseProvider {
  final databaseName = "notes.db";
  final tableName = "notes";
  
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
    return await openDatabase(join(await getDatabasesPath(), 'notes.db'),version: 1,
        onCreate: (db, version) async {
      //creating first table
      await db.execute('''
 CREATE TABLE notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  body TEXT,
  creationDate DATE
  )
''');
    });
  }

//function that will add a new note to our variable
  addNewNote(NoteModel note) async {
    final db = await database;
    db.insert("notes", note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//function that fetches from our database and returns all the
//elements inside the diary entries table
  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db.query("notes");
    if (res.isEmpty) {
      return Null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }
  Future<int> deleteNote(int id) async {

    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id=?", [id]);

    return count;
  }
}
