import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import 'db_constants.dart';

class DBHelper {
  static Database? _database;

  static final DBHelper instance = DBHelper._init();

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();

    final path = join(
      dbPath,
      DBConstants.dbName,
    );

    return await openDatabase(
      path,
      version: DBConstants.dbVersion,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(
      Database db,
      int version,
      ) async {
    await db.execute('''
      CREATE TABLE ${DBConstants.tableName} (
        ${DBConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBConstants.title} TEXT NOT NULL,
        ${DBConstants.amount} REAL NOT NULL,
        ${DBConstants.category} TEXT NOT NULL,
        ${DBConstants.date} TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertExpense(
      ExpenseModel expense,
      ) async {
    final db = await instance.database;

    return await db.insert(
      DBConstants.tableName,
      expense.toMap(),
    );
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final db = await instance.database;

    final result = await db.query(
      DBConstants.tableName,
      orderBy: '${DBConstants.date} DESC',
    );

    return result
        .map((e) => ExpenseModel.fromMap(e))
        .toList();
  }

  Future<int> updateExpense(
      ExpenseModel expense,
      ) async {
    final db = await instance.database;

    return await db.update(
      DBConstants.tableName,
      expense.toMap(),
      where: '${DBConstants.id} = ?',
      whereArgs: [expense.id],
    );
  }

  Future<int> deleteExpense(
      int id,
      ) async {
    final db = await instance.database;

    return await db.delete(
      DBConstants.tableName,
      where: '${DBConstants.id} = ?',
      whereArgs: [id],
    );
  }
}