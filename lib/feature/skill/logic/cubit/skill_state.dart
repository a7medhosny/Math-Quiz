part of 'skill_cubit.dart';

@immutable
sealed class SkillState {}

final class SkillInitial extends SkillState {}

final class SkillsLoading extends SkillState {}

final class SkillsLoaded extends SkillState {
  final List<SkillModel> skills;

  SkillsLoaded(this.skills);
}

final class SkillsError extends SkillState {
  final String message;

  SkillsError(this.message);
}
