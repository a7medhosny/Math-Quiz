import 'package:math_quiz/feature/answer/data/model/level_stats_model.dart';
import 'package:math_quiz/feature/answer/data/model/wrong_answer_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnswerDBHelper {
  static final AnswerDBHelper _instance = AnswerDBHelper._internal();
  factory AnswerDBHelper() => _instance;
  AnswerDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'answers.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE wrong_answers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        questionText TEXT,
        correctAnswer TEXT,
        userAnswer TEXT,
        level TEXT,
        skillId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE level_stats (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        level TEXT,
        totalQuestions INTEGER,
        correctAnswers INTEGER,
        skillId INTEGER
      )
    ''');
  }

  Future<void> insertWrongAnswer(WrongAnswerModel answer) async {
    final db = await database;
    await db.insert(
      'wrong_answers',
      answer.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllAnswers() async {
    final db = await database;
    final maps = await db.query('wrong_answers');
    return maps;
  }



  Future<void> deleteAnswersByLevel({
    required String level,
    required int skillId,
  }) async {
    final db = await database;
    await db.delete(
      'wrong_answers',
      where: 'level = ? AND skillId = ?',
      whereArgs: [level, skillId],
    );
  }

  Future<void> insertOrUpdateLevelStats(LevelStatsModel stats) async {
    final db = await database;
    final result = await db.query(
      'level_stats',
      where: 'level = ? AND skillId = ?',
      whereArgs: [stats.level, stats.skillId],
    );

    if (result.isNotEmpty) {
      await db.update(
        'level_stats',
        {
          'totalQuestions': stats.totalQuestions,
          'correctAnswers': stats.correctAnswers,
        },
        where: 'level = ? AND skillId = ?',
        whereArgs: [stats.level, stats.skillId],
      );
    } else {
      await db.insert(
        'level_stats',
        stats.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getAllLevelStats() async {
    final db = await database;
    final maps = await db.query('level_stats');
    return maps;
  }

  Future<void> deleteStatsByLevel(String level, int skillId) async {
    final db = await database;
    await db.delete(
      'level_stats',
      where: 'level = ? AND skillId = ?',
      whereArgs: [level, skillId],
    );
  }

 
}
