import 'package:json_annotation/json_annotation.dart';
part 'unit_model.g.dart';

@JsonSerializable()
class UnitModel {
  final int id;
  final String name;

  UnitModel({
    required this.id,
    required this.name,
  });

    factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitModelToJson(this);
}
