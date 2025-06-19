// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: (json['id'] as num).toInt(),
      skillId: (json['skill_id'] as num).toInt(),
      questionText: json['question_text'] as String,
      level: json['level'] as String,
      correctAnswer: json['correct_answer'] as String,
      type: json['type'] as String,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skill_id': instance.skillId,
      'question_text': instance.questionText,
      'level': instance.level,
      'correct_answer': instance.correctAnswer,
      'type': instance.type,
      'explanation': instance.explanation,
    };
