import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_quiz/core/DI/service_locator.dart';
import 'package:math_quiz/feature/answer/logic/cubit/answer_cubit.dart';
import 'package:math_quiz/feature/question/logic/cubit/question_cubit.dart';
import 'package:math_quiz/feature/quiz/logic/cubit/mcq_options_cubit.dart';
import 'package:math_quiz/feature/unit/cubit/unit_cubit.dart';
import 'package:math_quiz/feature/unit/unit.dart';
import 'package:math_quiz/feature/skill/logic/cubit/skill_cubit.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // screen util to make the app responsive
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<UnitCubit>(
              create: (context) => getIt<UnitCubit>()..loadUnits(),
            ),
            BlocProvider<McqOptionsCubit>(
              create: (context) => getIt<McqOptionsCubit>(),
            ),
            BlocProvider<SkillCubit>(create: (context) => getIt<SkillCubit>()),
            BlocProvider<QuestionCubit>(
              create: (context) => getIt<QuestionCubit>(),
            ),
            BlocProvider<AnswerCubit>(
              create: (context) => getIt<AnswerCubit>(),
            ),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: UnitScreen(),
          ),
        );
      },
    );
  }
}
