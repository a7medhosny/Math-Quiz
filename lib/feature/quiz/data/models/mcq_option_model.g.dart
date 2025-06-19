// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcq_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

McqOptionModel _$McqOptionModelFromJson(Map<String, dynamic> json) =>
    McqOptionModel(
      id: (json['id'] as num).toInt(),
      questionId: (json['question_id'] as num).toInt(),
      optionText: json['option_text'] as String,
      isConrect: (json['is_correct'] as num).toInt(),
    );

Map<String, dynamic> _$McqOptionModelToJson(McqOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'option_text': instance.optionText,
      'is_correct': instance.isConrect,
    };
