import 'package:math_quiz/core/helpers/answer_dp_helper.dart';
import 'package:math_quiz/feature/answer/data/model/level_stats_model.dart';
import 'package:math_quiz/feature/answer/data/model/wrong_answer_model.dart';

class AnswerRepo {
  final AnswerDBHelper answerDBHelper;
  AnswerRepo({required this.answerDBHelper});
  Future<List<WrongAnswerModel>> getAllWrongAnswers() async {
    try {
      final data = await answerDBHelper.getAllAnswers();
      return data.map((item) => WrongAnswerModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load wrong answers: $e');
    }
  }

  Future<void> insertWrongAnswer(WrongAnswerModel answer) async {
    try {
      await answerDBHelper.insertWrongAnswer(answer);
    } catch (e) {
      throw Exception('Failed to insert wrong answer: $e');
    }
  }

  Future<List<WrongAnswerModel>> getWrongAnswersByLevel({
    required String level,
    required int skillId,
  }) async {
    try {
      final allAnswers = await getAllWrongAnswers();
      return allAnswers
          .where(
            (answer) => (answer.level == level && answer.skillId == skillId),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to load wrong answers for level $level: $e');
    }
  }

  Future<void> deleteWrongAnswer({
    required String level,
    required int skillId,
  }) async {
    try {
      await answerDBHelper.deleteAnswersByLevel(level: level, skillId: skillId);
    } catch (e) {
      throw Exception('Failed to delete wrong answer: $e');
    }
  }

  Future<void> insertOrUpdateLevelStats(LevelStatsModel stats) async {
    try {
      await answerDBHelper.insertOrUpdateLevelStats(stats);
    } catch (e) {
      throw Exception('Failed to insert or update level stats: $e');
    }
  }

  Future<List<LevelStatsModel>> getLevelStats() async {
    try {
      final stats = await answerDBHelper.getAllLevelStats();
      return stats.map((item) => LevelStatsModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load level stats : $e');
    }
  }
}
