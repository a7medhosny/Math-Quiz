import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  final int id;
  @JsonKey(name: 'skill_id')
  final int skillId;
  @JsonKey(name: 'question_text')
  final String questionText;
  final String level;
  @JsonKey(name: 'correct_answer')
  final String correctAnswer;
  final String type;
  final String? explanation;

  QuestionModel({
    required this.id,
    required this.skillId,
    required this.questionText,
    required this.level,
    required this.correctAnswer,
    required this.type,
    required this.explanation,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
