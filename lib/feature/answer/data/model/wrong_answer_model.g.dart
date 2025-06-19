// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrongAnswerModel _$WrongAnswerModelFromJson(Map<String, dynamic> json) =>
    WrongAnswerModel(
      id: (json['id'] as num?)?.toInt(),
      questionText: json['questionText'] as String,
      correctAnswer: json['correctAnswer'] as String,
      userAnswer: json['userAnswer'] as String,
      level: json['level'] as String,
      skillId: (json['skillId'] as num).toInt(),
    );

Map<String, dynamic> _$WrongAnswerModelToJson(WrongAnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skillId': instance.skillId,
      'questionText': instance.questionText,
      'correctAnswer': instance.correctAnswer,
      'userAnswer': instance.userAnswer,
      'level': instance.level,
    };
