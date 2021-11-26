import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_qr_reader/models/scan_model.dart';
export 'package:flutter_qr_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  /* Future<Database>  */ get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    //select path para db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    //crear db
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
                       CREATE TABLE Scans(
                         id INTEGER PRIMARY KEY,
                         tipo TEXT,
                         valor TEXT
                       )
                ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel model) async {
    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans (id, tipo, valor) 
        VALUES (${model.id}, '${model.tipo}', '${model.valor}')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel model) async {
    final db = await database;
    final res = await db.insert('Scans', model.toJson());

    return res;
  }

  getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [id]);
    res as List;

    return res.isNotEmpty ? res.first : null;
  }

  getAllScans() async {
    final db = await database;
    final res = await db.query(
      'Scans',
    );
    res as List;

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  getScansByType(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo=?', whereArgs: [tipo]);
    res as List;

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel model) async {
    final db = await database;
    final res = await db
        .update('Scans', model.toJson(), where: 'id=?', whereArgs: [model.id]);
    return res;
  }

  Future<int> delteById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id=?', whereArgs: [id]);
    return res;
  }

  delteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
