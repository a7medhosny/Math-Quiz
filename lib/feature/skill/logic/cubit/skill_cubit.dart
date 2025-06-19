import 'package:bloc/bloc.dart';
import 'package:math_quiz/feature/skill/data/model/skill_model.dart';
import 'package:math_quiz/feature/skill/data/repo/skill_repo.dart';
import 'package:meta/meta.dart';

part 'skill_state.dart';

class SkillCubit extends Cubit<SkillState> {

final SkillRepo skillRepo;
  SkillCubit({required this.skillRepo}) : super(SkillInitial());

    void loadSkills({required int unitId}) async {
    try {
      emit(SkillsLoading());
      List<SkillModel> skills = await skillRepo.getSkillsByUnitId(
        unitId: unitId,
      );
      emit(SkillsLoaded(skills));
    } catch (e) {
      emit(SkillsError('Failed to load skills: $e'));
    }
  }
}
