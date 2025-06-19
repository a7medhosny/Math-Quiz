import 'package:math_quiz/core/helpers/db_helper.dart';
import 'package:math_quiz/feature/unit/data/models/unit_model.dart';

class UnitRepo {
  final DBHelper dbHelper;

  UnitRepo({required this.dbHelper});

  Future<List<UnitModel>> getAllUnits() async {
    try {
      final data = await dbHelper.getAllUnitss();
      return data.map((unit) => UnitModel.fromJson(unit)).toList();
    } catch (e) {
      throw Exception('Failed to load units: $e');
    }
  }
}
