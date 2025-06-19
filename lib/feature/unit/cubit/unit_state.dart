part of 'unit_cubit.dart';

@immutable
sealed class UnitState {}

final class UnitInitial extends UnitState {}
final class UnitsLoading extends UnitState {}
final class UnitsLoaded extends UnitState {
  final List<UnitModel> units;

  UnitsLoaded(this.units);
}
final class UnitsError extends UnitState {
  final String message;
  UnitsError(this.message);
}

// final class SkillsLoading extends UnitState {}
// final class SkillsLoaded extends UnitState {
//   final List<SkillModel> skills;

//   SkillsLoaded(this.skills);
// }
// final class SkillsError extends UnitState {
//   final String message;
//   SkillsError(this.message);
// }

// final class QuestionsLoading extends UnitState {}
// final class QuestionsLoaded extends UnitState {
//   final List<QuestionModel> questions;

//   QuestionsLoaded(this.questions);
// }
// final class QuestionsError extends UnitState {
//   final String message;
//   QuestionsError(this.message);
// }



