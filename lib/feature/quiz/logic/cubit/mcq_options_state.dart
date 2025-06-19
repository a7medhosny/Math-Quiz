part of 'mcq_options_cubit.dart';

@immutable
sealed class McqOptionsState {}

final class McqOptionsInitial extends McqOptionsState {}

final class McqOptionsLoading extends McqOptionsState {}
final class McqOptionsLoaded extends McqOptionsState {
  final List<McqOptionModel> mcqOptions;

  McqOptionsLoaded(this.mcqOptions);
}
final class McqOptionsError extends McqOptionsState {
  final String message;
  McqOptionsError(this.message);
}