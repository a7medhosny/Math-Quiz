import 'package:get_it/get_it.dart';
import 'package:math_quiz/core/helpers/answer_dp_helper.dart';
import 'package:math_quiz/core/helpers/db_helper.dart';
import 'package:math_quiz/feature/answer/data/repo/answer_repo.dart';
import 'package:math_quiz/feature/answer/logic/cubit/answer_cubit.dart';
import 'package:math_quiz/feature/question/data/repo/question_repo.dart';
import 'package:math_quiz/feature/question/logic/cubit/question_cubit.dart';
import 'package:math_quiz/feature/quiz/logic/cubit/mcq_options_cubit.dart';
import 'package:math_quiz/feature/skill/data/repo/skill_repo.dart';
import 'package:math_quiz/feature/skill/logic/cubit/skill_cubit.dart';
import 'package:math_quiz/feature/unit/data/repo/unit_repo.dart';
import 'package:math_quiz/feature/unit/cubit/unit_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Helpers
  getIt.registerLazySingleton<DBHelper>(() => DBHelper());
  getIt.registerLazySingleton<AnswerDBHelper>(() => AnswerDBHelper());

  // Repos
  getIt.registerLazySingleton<UnitRepo>(() => UnitRepo(dbHelper: getIt()));
  getIt.registerLazySingleton<SkillRepo>(() => SkillRepo(dbHelper: getIt()));
  getIt.registerLazySingleton<QuestionRepo>(() => QuestionRepo(dbHelper: getIt()));
  getIt.registerLazySingleton<AnswerRepo>(() => AnswerRepo(answerDBHelper: getIt()));

  // Cubits
  getIt.registerFactory<UnitCubit>(() => UnitCubit(homeRepo: getIt()));
  getIt.registerFactory<SkillCubit>(() => SkillCubit(skillRepo: getIt()));
  getIt.registerFactory<QuestionCubit>(() => QuestionCubit(questionRepo: getIt()));
  getIt.registerFactory<AnswerCubit>(() => AnswerCubit(answerRepo: getIt()));
  getIt.registerFactory<McqOptionsCubit>(() => McqOptionsCubit());
}
