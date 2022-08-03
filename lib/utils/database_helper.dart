
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/token.dart';


class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._createInstance();

  String tokenTable = 'token_table';
  String rollno = 'rollno';
  String accessToken = 'access_token';
  String refreshToken = 'refresh_token';

  factory DatabaseHelper() {
    return _databaseHelper ?? DatabaseHelper._createInstance();
  }

  Future<Database> get database async {
    return _database ?? await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'token.db';

    // Open/create the database at a given path
    var tokenDatabase =
    await openDatabase(path, version: 1, onCreate: _createDb);
    return tokenDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tokenTable($rollno TEXT PRIMARY, $accessToken TEXT,'
            '$refreshToken TEXT');
  }

  // Fetch operation
  Future<List<Map<String, dynamic>>> getTokenMapList() async {
    Database db = await this.database;
    //		var result = await db.rawQuery('SELECT rollno FROM $noteTable order by $colPriority ASC');
    var result = await db.query(tokenTable);
    return result;
  }


// Insert
  Future<int> insertNote(Token token) async {

    Database db = await this.database;
    var result = await db.insert(tokenTable, token.toMap());
    return result;
  }

  // Update
  Future<int> updateNote(Token token) async {
    Database db = await this.database;
    var result = await db.update(tokenTable, token.toMap(),
        where: '$rollno=?', whereArgs: [token.rollno]);
    return result;
  }

  Future<int?> deleteNote(int? id) async {
    if (rollno != null) {
      var db = await this.database;
      int result =
      await db.rawDelete('DELETE FROM $tokenTable WHERE $rollno = $rollno');
      return result;
    }
    return null;
  }

  // Get the mapList and convert to Note list
  Future<List<Token>> getTokenList() async {
    var tokenMapList = await getTokenMapList();
    int count = tokenMapList.length;

    // ignore: deprecated_member_use
    List<Token> tokenList = <Token>[];

    for (int i = 0; i < count; i++) {
      tokenMapList.add(Token.fromMapObject(tokenMapList[i]));
    }

    return tokenList;
  }
}
