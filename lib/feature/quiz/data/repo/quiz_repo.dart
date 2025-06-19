import 'package:math_quiz/core/helpers/db_helper.dart';
import 'package:math_quiz/feature/quiz/data/models/mcq_option_model.dart';

class QuizRepo {
    final DBHelper dbHelper;

  QuizRepo({required this.dbHelper});

   Future<List<McqOptionModel>> getAllMcqOptions() async {
    try {
      final mcqOptions = await dbHelper.getAllMcqOptions();
      return mcqOptions
          .map((mcqOptions) => McqOptionModel.fromJson(mcqOptions))
          .toList();
    } catch (e) {
      throw Exception('Failed to load mcq options: $e');
    }
  }
    Future<List<McqOptionModel>> getAllMcqOptionsByQuestionId({required int questionId}) async {
    try {
      final mcqOptions = await getAllMcqOptions();
      return mcqOptions
          .where((option) => option.questionId == questionId)
          .toList();
    } catch (e) {
      throw Exception('Failed to load mcq options: $e');
    }
  }
}