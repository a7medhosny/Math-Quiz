import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:math_quiz/feature/answer/data/model/level_stats_model.dart';
import 'package:math_quiz/feature/answer/data/model/wrong_answer_model.dart';
import 'package:math_quiz/feature/answer/data/repo/answer_repo.dart';

part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> {
  final AnswerRepo answerRepo;

  AnswerCubit({required this.answerRepo}) : super(AnswerInitial());

  Future<void> loadWrongAnswersByLevel({
    required String level,
    required int skillId,
  }) async {
    emit(WrongAnswersLoading());
    try {
      final answers = await answerRepo.getWrongAnswersByLevel(level: level, skillId: skillId);
      emit(WrongAnswersLoaded(answers));
    } catch (e) {
      emit(WrongAnswersError(e.toString()));
    }
  }

 Future<void> loadWrongAnswers() async {
    emit(WrongAnswersLoading());
    try {
      final answers = await answerRepo.getAllWrongAnswers();
      emit(WrongAnswersLoaded(answers));
    } catch (e) {
      emit(WrongAnswersError(e.toString()));
    }
  }
  Future<void> addWrongAnswer(WrongAnswerModel answer) async {
    try {
      await answerRepo.insertWrongAnswer(answer);
    } catch (e) {
      emit(WrongAnswersError(e.toString()));
    }
  }

  Future<void> deleteWrongAnswersByLevel({  required String level,
   required int skillId,}) async {
    try {
      await answerRepo.deleteWrongAnswer(
        level: level,
        skillId: skillId, 
      );
    } catch (e) {
      emit(WrongAnswersError(e.toString()));
    }
  }

  Future<void> insertOrUpdateLevelStats(LevelStatsModel stats) async {
    try {
      await answerRepo.insertOrUpdateLevelStats(stats);
    } catch (e) {
      emit(LevelStatsError(e.toString()));
    }
  }

  Future<void> loadLevelStats() async {
    emit(LevelStatsLoading());
    try {
      final stats = await answerRepo.getLevelStats();
      emit(LevelStatsLoaded(stats));
    } catch (e) {
      emit(LevelStatsError(e.toString()));
    }
  }
}
