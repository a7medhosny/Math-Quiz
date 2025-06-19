import 'package:json_annotation/json_annotation.dart';

part 'level_stats_model.g.dart';

@JsonSerializable()
class LevelStatsModel {
  final int? id;
  final int skillId;
  final String level;
  final int totalQuestions;
  final int correctAnswers;

  LevelStatsModel({
    required this.id,
    required this.level,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.skillId,
  });
  factory LevelStatsModel.fromJson(Map<String, dynamic> json) =>
      _$LevelStatsModelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelStatsModelToJson(this);
}
