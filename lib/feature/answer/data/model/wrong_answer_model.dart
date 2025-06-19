import 'package:json_annotation/json_annotation.dart';
part 'wrong_answer_model.g.dart';

@JsonSerializable()
class WrongAnswerModel {
  final int? id;
  final int skillId;
  final String questionText;
  final String correctAnswer;
  final String userAnswer;
  final String level;

  WrongAnswerModel({
    required this.id,
    required this.questionText,
    required this.correctAnswer,
    required this.userAnswer,
    required this.level,
    required this.skillId,
  });

  factory WrongAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$WrongAnswerModelFromJson(json);
  Map<String, dynamic> toJson() => _$WrongAnswerModelToJson(this);
}
