import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_quiz/feature/answer/data/model/level_stats_model.dart';
import 'package:math_quiz/feature/answer/logic/cubit/answer_cubit.dart';
import 'package:math_quiz/feature/quiz/ui/widgets/show_mistakes_button.dart';
import 'package:math_quiz/feature/unit/unit.dart';

class QuizResult extends StatelessWidget {
  final int skillId;
  final String level;

  const QuizResult({super.key, required this.skillId, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Result',
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<AnswerCubit, AnswerState>(
        buildWhen:
            (previous, current) =>
                current is LevelStatsLoading ||
                current is LevelStatsLoaded ||
                current is LevelStatsError,
        builder: (context, state) {
          if (state is LevelStatsError) {
            return _buildError(context, state.message);
          } else if (state is LevelStatsLoaded) {
            final levelStats = state.stats;
            final skillStats = getLevelStats(levelStats, skillId, level);
            return _buildLevelLoaded(context, skillStats);
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  _buildError(BuildContext context, String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 16.sp, color: Colors.red),
      ),
    );
  }

  _buildLevelLoaded(BuildContext context, LevelStatsModel skillStats) {
    int correctAnswersCount = skillStats.correctAnswers;
    int totalQuestions = skillStats.totalQuestions;
    double progress =
        totalQuestions == 0 ? 0 : (correctAnswersCount / totalQuestions) * 100;

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildScoreCard(correctAnswersCount, totalQuestions, progress),
          SizedBox(height: 30.h),
          ShowMistakesButton(skillId: skillId, level: level),
          const Spacer(),
          _buildFinishButton(context),
        ],
      ),
    );
  }

  _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildScoreCard(
    int correctAnswersCount,
    int totalQuestions,
    double progress,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          children: [
            Text(
              '$correctAnswersCount / $totalQuestions Correct',
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 12.h),
            LinearProgressIndicator(
              value:
                  totalQuestions == 0
                      ? 0
                      : correctAnswersCount / totalQuestions,
              backgroundColor: Colors.grey[300],
              color: Colors.deepPurple,
              minHeight: 10.h,
              borderRadius: BorderRadius.circular(8),
            ),
            SizedBox(height: 12.h),
            Text(
              '${progress.toStringAsFixed(0)}% Score',
              style: TextStyle(fontSize: 18.sp, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UnitScreen()),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Finish',
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
      ),
    );
  }

  LevelStatsModel getLevelStats(
    List<LevelStatsModel> stats,
    int skillId,
    String level,
  ) {
    return stats.firstWhere(
      (s) =>
          s.skillId == skillId && s.level.toLowerCase() == level.toLowerCase(),
      orElse:
          () => LevelStatsModel(
            id: null,
            skillId: skillId,
            level: level,
            totalQuestions: 0,
            correctAnswers: 0,
          ),
    );
  }
}
