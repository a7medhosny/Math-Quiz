import 'package:json_annotation/json_annotation.dart';

part 'mcq_option_model.g.dart';

@JsonSerializable()
class McqOptionModel {
  final int id;
  @JsonKey(name: 'question_id')
  final int questionId;
  @JsonKey(name: 'option_text')
  final String optionText;
  @JsonKey(name: 'is_correct')
  final int isConrect;

  McqOptionModel({
    required this.id,
    required this.questionId,
    required this.optionText,
    required this.isConrect,
  });

  factory McqOptionModel.fromJson(Map<String, dynamic> json) =>
      _$McqOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$McqOptionModelToJson(this);
}
