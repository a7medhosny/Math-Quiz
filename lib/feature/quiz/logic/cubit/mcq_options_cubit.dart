import 'package:bloc/bloc.dart';
import 'package:math_quiz/core/helpers/db_helper.dart';
import 'package:math_quiz/feature/quiz/data/models/mcq_option_model.dart';
import 'package:math_quiz/feature/unit/data/repo/unit_repo.dart';
import 'package:math_quiz/feature/quiz/data/repo/quiz_repo.dart';
import 'package:meta/meta.dart';

part 'mcq_options_state.dart';

class McqOptionsCubit extends Cubit<McqOptionsState> {
  McqOptionsCubit() : super(McqOptionsInitial());

   void loadSMcqOptions({required int questionId}) async {
    try {
      emit(McqOptionsLoading());
      List<McqOptionModel> mcqOptions = await QuizRepo(dbHelper: DBHelper())
          .getAllMcqOptionsByQuestionId(questionId: questionId);

      emit(McqOptionsLoaded(mcqOptions));
    } catch (e) {
      emit(McqOptionsError('Failed to load Mcq: $e'));
    }
  }
}
