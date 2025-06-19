import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_quiz/feature/answer/data/model/level_stats_model.dart';
import 'package:math_quiz/feature/answer/data/model/wrong_answer_model.dart';
import 'package:math_quiz/feature/answer/logic/cubit/answer_cubit.dart';
import 'package:math_quiz/feature/question/ui/screens/question_creation.dart';

class SkillPerformance extends StatelessWidget {
  final String skillName;
  final int skillId;

  const SkillPerformance({
    super.key,
    required this.skillName,
    required this.skillId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$skillName Progress',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white, size: 22.sp),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<AnswerCubit, AnswerState>(
      buildWhen:
          (previous, current) =>
              current is LevelStatsLoading ||
              current is LevelStatsLoaded ||
              current is LevelStatsError,
      builder: (context, state) {
        if (state is LevelStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LevelStatsLoaded) {
          final stats = state.stats;

          // Function to calculate percentage for each level
          double getPercentage(String level) {
            final item = stats.firstWhere(
              (s) =>
                  s.level.toLowerCase() == level.toLowerCase() &&
                  s.skillId == skillId,
              orElse:
                  () => LevelStatsModel(
                    id: null,
                    skillId: skillId,
                    level: level,
                    totalQuestions: 0,
                    correctAnswers: 0,
                  ),
            );
            if (item.totalQuestions == 0) return 0;
            return item.correctAnswers / item.totalQuestions;
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildProgressCard(
                  context: context,
                  title: "Easy",
                  percentage: getPercentage("easy"),
                  color: Colors.green,
                  onViewMistakes: () => _showMistakes(context, "easy"),
                ),
                _buildProgressCard(
                  context: context,
                  title: "Medium",
                  percentage: getPercentage("medium"),
                  color: Colors.orange,
                  onViewMistakes: () => _showMistakes(context, "medium"),
                ),
                _buildProgressCard(
                  context: context,
                  title: "Hard",
                  percentage: getPercentage("hard"),
                  color: Colors.red,
                  onViewMistakes: () => _showMistakes(context, "hard"),
                ),
                const Spacer(),
                _buildCreateQuizSection(context),
              ],
            ),
          );
        } else if (state is LevelStatsError) {
          return Center(
            child: Text(state.message, style: TextStyle(fontSize: 16.sp)),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildProgressCard({
    required BuildContext context,
    required String title,
    required double percentage,
    required Color color,
    required VoidCallback onViewMistakes,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 80.w,
                  width: 80.w,
                  child: CircularProgressIndicator(
                    value: percentage,
                    strokeWidth: 10.w,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                Text(
                  "${(percentage * 100).toInt()}%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 8.w),
            ElevatedButton.icon(
              onPressed: onViewMistakes,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              ),
              icon: Icon(Icons.error, color: Colors.white, size: 18.sp),
              label: Text(
                'View Mistakes',
                style: TextStyle(fontSize: 10.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateQuizSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create a quiz to test your skills',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionCreation(skillId: skillId),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon: Icon(Icons.quiz, color: Colors.white, size: 20.sp),
            label: Text(
              'Create Quiz',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }

  void _showMistakes(BuildContext context, String level) async {
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
        builder: (_) => _buildWrongAnswersSheet(state.wrongAnswers, level),
      );
    }
  }

  Widget _buildWrongAnswersSheet(
    List<WrongAnswerModel> wrongAnswers,
    String level,
  ) {
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
          Divider(
            height: 24.h,
            thickness: 1,
            color: Colors.deepPurple.shade200,
          ),

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
