import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'movies.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE favorite_movies(id TEXT PRIMARY KEY, title TEXT, image TEXT, description TEXT , rate REAL, type TEXT , year TEXT  )');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> delete(String id) async {
    final db = await DBHelper.database();
    await db.delete('favorite_movies', where: 'id = ?', whereArgs: [id]);
  }

  // static Future<void> update(String id) async {
  //   final db = await DBHelper.database();
  //   db.update('favorite_movies', dataType, where: 'id = ?', whereArgs: [id]);
  // }
}
