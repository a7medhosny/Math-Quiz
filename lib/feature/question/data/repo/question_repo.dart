import 'package:math_quiz/core/helpers/db_helper.dart';
import 'package:math_quiz/feature/question/data/models/question_model.dart';

class QuestionRepo {
  final DBHelper dbHelper;
  QuestionRepo({required this.dbHelper});

    Future<List<QuestionModel>> getAllQuestions() async {
    try {
      final questions = await dbHelper.getAllQuestions();
      return questions
          .map((question) => QuestionModel.fromJson(question))
          .toList();
    } catch (e) {
      throw Exception('Failed to load questions: $e');
    }
  }

  Future<List<QuestionModel>> getQuestionsByDifficultyAndSkillId({
    required String level,
    required int skillId,
    required int limit,
  }) async {
    try {
      final questions = await getAllQuestions();
      final filteredQuestions =
          questions
              .where(
                (question) =>
                    question.level == level && question.skillId == skillId,
              )
              .toList();

      filteredQuestions.shuffle();

      return filteredQuestions.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to load questions for level and skill: $e');
    }
  }
}