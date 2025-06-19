import 'package:json_annotation/json_annotation.dart';

part 'skill_model.g.dart';

@JsonSerializable()
class SkillModel {
  final int id;
  @JsonKey(name: 'unit_id')
  final int unitId;
  final String name;

  SkillModel({required this.id, required this.unitId, required this.name});

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);

  Map<String, dynamic> toJson() => _$SkillModelToJson(this);
}
