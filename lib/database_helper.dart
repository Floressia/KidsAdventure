import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE UserData (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            avatarIndex INTEGER
          )
        ''');
      },
    );
  }

  Future<void> saveUserData(String name, int avatarIndex) async {
    final db = await database;
    await db.insert(
      'UserData',
      {'name': name, 'avatarIndex': avatarIndex},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('UserData', limit: 1);
    return results.isNotEmpty ? results.first : null;
  }
}
