import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database;
  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('Notes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE Notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pin BOOLEAN NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      createdTime TEXT NOT NULL
    )
    ''');
  }

  Future<bool?> insertEntry() async {
    final db = await instance.database;
    await db?.insert("Notes", {
      "pin": 0,
      "title": "This is my title",
      "content": "This is my content and I think this is not enough",
      "createdTime": "26 June 2018"
    });
    return true;
  }

  Future<String?> readAllNotes() async {
    final db = await instance.database;
    final orderBy = 'createdTime ASC';
    final query_result = db!.query('Notes', orderBy: orderBy);
    print(query_result);
    return "SUCCESSFULL";
  }

  Future<String?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db?.query('Notes' ,columns: ["id","title", "createdTime"],
    where: 'id = ?', whereArgs: [id]
    );
    print(map);
  }

}
