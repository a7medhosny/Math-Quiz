import 'package:bloc/bloc.dart';
import 'package:math_quiz/feature/question/data/models/question_model.dart';
import 'package:math_quiz/feature/question/data/repo/question_repo.dart';
import 'package:meta/meta.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final QuestionRepo questionRepo;
  QuestionCubit({required this.questionRepo}) : super(QuestionInitial());

    void loadSQuestions({
    required String level,
    required int skillId,
    required int limit,
  }) async {
    try {
      emit(QuestionsLoading());
      List<QuestionModel> questions = await questionRepo
          .getQuestionsByDifficultyAndSkillId(
            level: level,
            skillId: skillId,
            limit: limit,
          );

      emit(QuestionsLoaded(questions));
    } catch (e) {
      emit(QuestionsError('Failed to load Questions: $e'));
    }
  }
}
