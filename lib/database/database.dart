import 'package:flutter_prova2/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();
  Database? internal;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name Text, email TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<Database?> get database async {
    if (internal != null) return internal;
    internal = await initDatabase();
    return internal;
  }


  Future<void> insertUser(User user) async {
    final db = await database;

    await db!.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db!.query(
      'user',
      where: "email = ?",
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // Future<List<User>> getAllUsers() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> result = await db!.query('user');
  //   return List.generate(result.length, (i) {
  //     return User.fromMap(result[i]);
  //   });
  // }
}
