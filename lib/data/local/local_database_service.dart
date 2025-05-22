import 'package:sqflite/sqflite.dart';
import 'package:tourism_app/data/model/tourism.dart';

class LocalDatabaseService {
  static const String _dbName = 'tourism-app.db';
  static const String _tableName = 'tourism';
  static const int _version = 1;

  Future<void> createTables(Database db) async {
    await db.execute('''CREATE TABLE $_tableName(
       id INTEGER PRIMARY KEY,
       name TEXT,
       description TEXT,
       address TEXT,
       longitude REAL,
       latitude REAL,
       like INTEGER,
       image TEXT
      )
    ''');
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _dbName,
      version: _version,
      onCreate: (Database db, int version) async {
        await createTables(db);
      },
    );
  }

  Future<int> insertItem(Tourism tourism) async {
    final db = await _initializeDb();
    final data = tourism.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Tourism>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) => Tourism.fromJson(result)).toList();
  }

  Future<Tourism> getItemById(int id) async {
    final db = await _initializeDb();
    final results = await db.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
    return results.map((result) => Tourism.fromJson(result)).first;
  }

  Future<int> removeItem(int id) async {
    final db = await _initializeDb();
    final result = await db.delete(_tableName, where: "id = ?", whereArgs: [id]);

    return result;
  }
}
