part of 'answer_cubit.dart';

@immutable
abstract class AnswerState {}

class AnswerInitial extends AnswerState {}

class WrongAnswersLoading extends AnswerState {}

class WrongAnswersLoaded extends AnswerState {
  final List<WrongAnswerModel> wrongAnswers;
  WrongAnswersLoaded(this.wrongAnswers);
}

class WrongAnswersError extends AnswerState {
  final String message;
  WrongAnswersError(this.message);
}

class LevelStatsLoading extends AnswerState {}

class LevelStatsLoaded extends AnswerState {
  final List<LevelStatsModel> stats;
  LevelStatsLoaded(this.stats);
}

class LevelStatsError extends AnswerState {
  final String message;
  LevelStatsError(this.message);
}
