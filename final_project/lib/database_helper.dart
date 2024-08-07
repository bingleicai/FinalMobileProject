import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'models/airplane.dart';  // Import the Airplane class
import 'models/customer.dart';  // Import the Customer class
import 'models/flight.dart';    // Import the Flight class

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

    String path = join(await getDatabasesPath(), 'flights_airplanes.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
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

    await db.execute('''
      CREATE TABLE flights (
        id INTEGER PRIMARY KEY,
        departureCity TEXT,
        destinationCity TEXT,
        departureTime TEXT,
        arrivalTime TEXT,
        airplaneId INTEGER,
        FOREIGN KEY(airplaneId) REFERENCES airplanes(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY,
        firstName TEXT,
        lastName TEXT,
        address TEXT,
        birthday TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE reservations (
        id INTEGER PRIMARY KEY,
        customerId INTEGER,
        flightId INTEGER,
        reservationName TEXT,
        FOREIGN KEY(customerId) REFERENCES customers(id),
        FOREIGN KEY(flightId) REFERENCES flights(id)
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE customers (
          id INTEGER PRIMARY KEY,
          firstName TEXT,
          lastName TEXT,
          address TEXT,
          birthday TEXT
        )
      ''');
    }
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE reservations (
          id INTEGER PRIMARY KEY,
          customerId INTEGER,
          flightId INTEGER,
          reservationName TEXT,
          FOREIGN KEY(customerId) REFERENCES customers(id),
          FOREIGN KEY(flightId) REFERENCES flights(id)
        )
      ''');
    }
  }

  // Airplanes methods
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

  // Flights methods
  Future<int> insertFlight(Map<String, dynamic> flight) async {
    try {
      final db = await database;
      return await db.insert('flights', flight);
    } catch (e) {
      print('Error inserting flight: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getFlights() async {
    try {
      final db = await database;
      return await db.query('flights');
    } catch (e) {
      print('Error fetching flights: $e');
      return [];
    }
  }

  Future<int> updateFlight(Map<String, dynamic> flight) async {
    try {
      final db = await database;
      return await db.update(
        'flights',
        flight,
        where: 'id = ?',
        whereArgs: [flight['id']],
      );
    } catch (e) {
      print('Error updating flight: $e');
      return -1;
    }
  }

  Future<int> deleteFlight(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'flights',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting flight: $e');
      return -1;
    }
  }

  // Customers methods
  Future<List<Customer>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('customers');

    return List.generate(maps.length, (i) {
      return Customer.fromMap(maps[i]);
    });
  }

  Future<void> insertCustomer(Customer customer) async {
    final db = await database;
    await db.insert(
      'customers',
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCustomer(Customer customer) async {
    final db = await database;
    await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<void> deleteCustomer(int id) async {
    final db = await database;
    await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Reservations methods
  Future<int> insertReservation(Map<String, dynamic> reservation) async {
    try {
      final db = await database;
      return await db.insert('reservations', reservation);
    } catch (e) {
      print('Error inserting reservation: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getReservations() async {
    try {
      final db = await database;
      return await db.query('reservations');
    } catch (e) {
      print('Error fetching reservations: $e');
      return [];
    }
  }

  Future<int> updateReservation(Map<String, dynamic> reservation) async {
    try {
      final db = await database;
      return await db.update(
        'reservations',
        reservation,
        where: 'id = ?',
        whereArgs: [reservation['id']],
      );
    } catch (e) {
      print('Error updating reservation: $e');
      return -1;
    }
  }

  Future<int> deleteReservation(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'reservations',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting reservation: $e');
      return -1;
    }
  }
}
