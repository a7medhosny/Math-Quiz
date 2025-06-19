import 'package:bloc/bloc.dart';
import 'package:math_quiz/core/helpers/db_helper.dart';
import 'package:math_quiz/feature/quiz/data/models/mcq_option_model.dart';
import 'package:math_quiz/feature/question/data/models/question_model.dart';
import 'package:math_quiz/feature/skill/data/model/skill_model.dart';
import 'package:math_quiz/feature/unit/data/models/unit_model.dart';
import 'package:math_quiz/feature/unit/data/repo/unit_repo.dart';
import 'package:meta/meta.dart';

part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  UnitCubit({required this.homeRepo}) : super(UnitInitial());
  final UnitRepo homeRepo;
  // final List<Map<String, String>> units = [
  //   {
  //     'name': 'Addition',
  //     'description': 'Combining two or more numbers to get their total.',
  //   },
  //   {
  //     'name': 'Subtraction',
  //     'description': 'Finding the difference between two numbers.',
  //   },
  //   {
  //     'name': 'Multiplication',
  //     'description': 'Calculating the total of equal groups of a number.',
  //   },
  //   {
  //     'name': 'Division',
  //     'description': 'Splitting a number into equal parts or groups.',
  //   },
  //   {
  //     'name': 'Square Root',
  //     'description':
  //         'Finding a number that, when multiplied by itself, gives the original number.',
  //   },
  // ];

  void loadUnits() async {
    List<UnitModel> units = await homeRepo.getAllUnits();
    emit(UnitsLoaded(units));
  }
}
