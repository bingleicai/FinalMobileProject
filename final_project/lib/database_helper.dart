import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'models/airplane.dart';  // Import the Airplane class

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String path = join(await getDatabasesPath(), 'airplanes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE airplanes (
        id INTEGER PRIMARY KEY,
        type TEXT,
        numberOfPassengers INTEGER,
        maxSpeed REAL,
        range REAL
      )
    ''');
  }

  Future<List<Airplane>> getAirplanes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('airplanes');

    return List.generate(maps.length, (i) {
      return Airplane.fromMap(maps[i]);
    });
  }

  Future<void> insertAirplane(Airplane airplane) async {
    final db = await database;
    await db.insert(
      'airplanes',
      airplane.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAirplane(Airplane airplane) async {
    final db = await database;
    await db.update(
      'airplanes',
      airplane.toMap(),
      where: 'id = ?',
      whereArgs: [airplane.id],
    );
  }

  Future<void> deleteAirplane(int id) async {
    final db = await database;
    await db.delete(
      'airplanes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
