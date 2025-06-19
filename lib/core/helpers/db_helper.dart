import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "math_quiz.db");

    bool dbExists = await File(path).exists();

    if (!dbExists) {
      ByteData data = await rootBundle.load("assets/db/math_quiz.db");
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, readOnly: true);
  }

   Future<List<Map<String, dynamic>>> getAllUnitss() async {
    final db = await DBHelper.database;
    return await db.query('units');
  }

   Future<List<Map<String, dynamic>>> getAllSkills() async {
    final db = await DBHelper.database;
    return await db.query('skills');
  }

   Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final db = await DBHelper.database;
    return await db.query('questions');
  }

   Future<List<Map<String, dynamic>>> getAllMcqOptions() async {
    final db = await DBHelper.database;
    return await db.query('mcq_options');
  }
}
