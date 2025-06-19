// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelStatsModel _$LevelStatsModelFromJson(Map<String, dynamic> json) =>
    LevelStatsModel(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] as String,
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      skillId: (json['skillId'] as num).toInt(),
    );

Map<String, dynamic> _$LevelStatsModelToJson(LevelStatsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skillId': instance.skillId,
      'level': instance.level,
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
    };
