part of 'question_cubit.dart';

@immutable
sealed class QuestionState {}

final class QuestionInitial extends QuestionState {}

final class QuestionsLoading extends QuestionState {}

final class QuestionsLoaded extends QuestionState {
  final List<QuestionModel> questions;

  QuestionsLoaded(this.questions);
}

final class QuestionsError extends QuestionState {
  final String message;

  QuestionsError(this.message);
}
