// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SkillModel _$SkillModelFromJson(Map<String, dynamic> json) => SkillModel(
  id: (json['id'] as num).toInt(),
  unitId: (json['unit_id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$SkillModelToJson(SkillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'unit_id': instance.unitId,
      'name': instance.name,
    };
