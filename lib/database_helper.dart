import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';

  static final colId = 'id';
  static final colName1 = 'task';
  static final colName2 = 'cboxvalue';

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();

    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    return db.query('''
      CREATE TABLE $_tableName ($colId INTEGER PRIMARY KEY,
      $colName1 TEXT NOT NULL,
      $colName2 TEXT NOT NULL)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.database;

    return await db.query(_tableName);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;

    return await db.delete(_tableName, where: '$colId = ?', whereArgs: [id]);
  }
}
