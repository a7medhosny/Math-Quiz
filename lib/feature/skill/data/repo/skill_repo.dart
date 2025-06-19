
import 'package:math_quiz/core/helpers/db_helper.dart';
import 'package:math_quiz/feature/skill/data/model/skill_model.dart';

class SkillRepo {
final DBHelper dbHelper;
  SkillRepo({required this.dbHelper});
  
  Future<List<SkillModel>> getAllSkills() async {
    try {
      final data = await dbHelper.getAllSkills();
      return data.map((skill) => SkillModel.fromJson(skill)).toList();
    } catch (e) {
      throw Exception('Failed to load skills: $e');
    }
  }

  Future<List<SkillModel>> getSkillsByUnitId({required int unitId}) async {
    try {
      List<SkillModel> skillModels = await getAllSkills();
      List<SkillModel> filteredSkills =
          skillModels.where((skill) => skill.unitId == unitId).toList();
      return filteredSkills;
    } catch (error) {
      throw Exception('Failed to load skills for unit $unitId: $error');
    }
  }
  }