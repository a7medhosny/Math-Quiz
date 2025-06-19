import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_quiz/feature/answer/logic/cubit/answer_cubit.dart';
import 'package:math_quiz/feature/answer/data/model/wrong_answer_model.dart';

class ShowMistakesButton extends StatelessWidget {
  const ShowMistakesButton({
    super.key,
    required this.skillId,
    required this.level,
  });

  final int skillId;
  final String level;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton.icon(
        icon: Icon(Icons.visibility_outlined, size: 20.sp, color: Colors.white),
        label: Text(
          'Show Mistakes',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
        onPressed: () => _showMistakes(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  void _showMistakes(BuildContext context) async {
    await context.read<AnswerCubit>().loadWrongAnswersByLevel(
      level: level,
      skillId: skillId,
    );

    final state = context.read<AnswerCubit>().state;
    if (state is WrongAnswersLoaded) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        isScrollControlled: true,
        builder: (_) => _buildWrongAnswersSheet(state.wrongAnswers),
      );
    }
  }

  Widget _buildWrongAnswersSheet(List<WrongAnswerModel> wrongAnswers) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Mistakes - $level',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 16.h),
          if (wrongAnswers.isEmpty)
            Text(
              'No mistakes in this level 🎉',
              style: TextStyle(color: Colors.green, fontSize: 16.sp),
            )
          else
            SizedBox(
              height: 300.h,
              child: ListView.separated(
                itemCount: wrongAnswers.length,
                separatorBuilder: (_, __) => Divider(height: 10.h),
                itemBuilder: (context, index) {
                  final e = wrongAnswers[index];
                  return ListTile(
                    leading: Icon(Icons.close, color: Colors.red, size: 20.sp),
                    title: Text(
                      '${e.questionText} = ${e.correctAnswer}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    subtitle: Text(
                      'Your answer: ${e.userAnswer}',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
