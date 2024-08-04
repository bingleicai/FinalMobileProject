import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Airplane {
  int? id;
  String type;
  int numberOfPassengers;
  double maxSpeed;
  double range;

  Airplane({
    this.id,
    required this.type,
    required this.numberOfPassengers,
    required this.maxSpeed,
    required this.range,
  });

  // Convert an Airplane object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'numberOfPassengers': numberOfPassengers,
      'maxSpeed': maxSpeed,
      'range': range,
    };
  }

  // Extract an Airplane object from a Map object
  factory Airplane.fromMap(Map<String, dynamic> map) {
    return Airplane(
      id: map['id'],
      type: map['type'],
      numberOfPassengers: map['numberOfPassengers'],
      maxSpeed: map['maxSpeed'],
      range: map['range'],
    );
  }
}

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
    String path = join(await getDatabasesPath(), 'airplanes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE airplanes(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, numberOfPassengers INTEGER, maxSpeed REAL, range REAL)',
    );
  }

  Future<void> insertAirplane(Airplane airplane) async {
    final db = await database;
    await db.insert(
      'airplanes',
      airplane.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Airplane>> getAirplanes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('airplanes');

    return List.generate(maps.length, (i) {
      return Airplane.fromMap(maps[i]);
    });
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