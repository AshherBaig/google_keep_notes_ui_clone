import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:google_keep_notes_ui_clone/model/notes_model.dart';

class MyNotesDatabase {
  static final MyNotesDatabase instance = MyNotesDatabase._init();
  static Database? _database;
  MyNotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Notes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE ${NotesImpNames.table}(
      ${NotesImpNames.id} $idType,
      ${NotesImpNames.pin} $boolType,
      ${NotesImpNames.isArchive} $boolType,
      ${NotesImpNames.title} $textType,
      ${NotesImpNames.content} $textType,
      ${NotesImpNames.createdTime} $textType
    )
    ''');
  }

  Future<MyNotesModel?> InsertEntry(MyNotesModel note) async {
    final db = await instance.database;
    
     final id = await db!.insert(NotesImpNames.table, note.toJson());
  
    return note.copy(id: id);
  }

  Future<List<MyNotesModel>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${NotesImpNames.createdTime} ASC';
    final query_result = await db!.query(NotesImpNames.table, orderBy: orderBy);
    // print(query_result);
    return query_result.map((json) => MyNotesModel.fromJson(json)).toList();
  }

  Future<MyNotesModel?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!.query(NotesImpNames.table, columns: NotesImpNames.values, where: '${NotesImpNames.id} = ?', whereArgs: [id]);
      if (map.isNotEmpty)
      {
        return MyNotesModel.fromJson(map.first);
      }
      else {return null;}
  }

  Future updateNote(MyNotesModel note) async {
    final db = await instance.database;
     await db!.update(NotesImpNames.table, note.toJson(),
        where: '${NotesImpNames.id} = ?', whereArgs: [note.id]);
  }

  Future pinNote(MyNotesModel note) async {
    final db = await instance.database;
     await db!.update(NotesImpNames.table, {NotesImpNames.pin : !note.pin ? 1 : 0} ,
        where: '${NotesImpNames.id} = ?', whereArgs: [note.id]);
  }

  Future archNote(MyNotesModel note) async {
    final db = await instance.database;
     await db!.update(NotesImpNames.table, {NotesImpNames.isArchive : !note.isArchive ? 1 : 0} ,
        where: '${NotesImpNames.id} = ?', whereArgs: [note.id]);
  }

  Future<List<int>> getString(String query) async {
    final db = await instance.database;
    final result = await db!.query(NotesImpNames.table);
    List<int> resultIds = [];
    result.forEach((element){
      if(element["title"].toString().toLowerCase().contains(query) || element["content"].toString().toLowerCase().contains(query))
      {
        resultIds.add(element["id"] as int);
      }
    });
    return resultIds;
  }

  Future deleteRow(MyNotesModel note) async {
    final db = await instance.database;
    await db?.delete(NotesImpNames.table, where: "${NotesImpNames.id} = ?", whereArgs: [note.id]);
  }

  Future closeDB() async {
    final db = await instance.database;
    db!.close();
  }
  
}
