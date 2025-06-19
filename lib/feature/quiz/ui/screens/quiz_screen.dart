import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_quiz/feature/answer/data/model/level_stats_model.dart';
import 'package:math_quiz/feature/answer/data/model/wrong_answer_model.dart';
import 'package:math_quiz/feature/answer/logic/cubit/answer_cubit.dart';
import 'package:math_quiz/feature/question/logic/cubit/question_cubit.dart';
import 'package:math_quiz/feature/quiz/logic/cubit/mcq_options_cubit.dart';
import 'package:math_quiz/feature/question/data/models/question_model.dart';
import 'package:math_quiz/feature/quiz/ui/widgets/fill_answer_field.dart';
import 'package:math_quiz/feature/quiz/ui/widgets/mcq_options.dart';
import 'package:math_quiz/feature/quiz/ui/widgets/question_progress.dart';
import 'package:math_quiz/feature/quiz/ui/screens/quiz_result.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int? selectedOptionId;
  String? selectedMcqOption;
  List<String> wrongAnswers = [];
  bool checkFirstQuestionIsMcq = true;
  final TextEditingController answerController = TextEditingController();

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void _loadOptionsIfNeeded() {
    final state = context.read<QuestionCubit>().state;
    if (state is QuestionsLoaded) {
      final currentQuestion = state.questions[index];
      if (currentQuestion.type == 'mcq') {
        context.read<McqOptionsCubit>().loadSMcqOptions(
          questionId: currentQuestion.id,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Screen',
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<QuestionCubit, QuestionState>(
        builder: (context, state) {
          if (state is QuestionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionsError) {
            return _buildError(state.message);
          } else if (state is QuestionsLoaded) {
            return _buildQuizBody(state.questions);
          } else {
            return _buildInitialMessage();
          }
        },
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(color: Colors.red, fontSize: 18.sp),
      ),
    );
  }

  Widget _buildInitialMessage() {
    return Center(
      child: Text(
        'Select quiz settings and press Start.',
        style: TextStyle(fontSize: 16.sp),
      ),
    );
  }

  Widget _buildQuizBody(List<QuestionModel> questions) {
    if (questions.isEmpty) {
      return Center(
        child: Text('No questions found.', style: TextStyle(fontSize: 16.sp)),
      );
    }

    final question = questions[index];
    if (question.type == 'mcq' && checkFirstQuestionIsMcq) {
      _loadOptionsIfNeeded();
      checkFirstQuestionIsMcq = false;
    }
    checkFirstQuestionIsMcq = false;

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionProgress(
            currentIndex: index,
            totalQuestions: questions.length,
          ),

          SizedBox(height: 24.h),

          _buildQuestionText(question.questionText),

          SizedBox(height: 16.h),

          if (question.type == 'mcq')
            McqOptions(
              selectedOptionId: selectedOptionId,
              onOptionSelected:
                  (val) => setState(() {
                    if (selectedOptionId == val) {
                      selectedOptionId = null;
                    } else {
                      selectedOptionId = val;
                    }
                  }),
              onMcqTextSelected:
                  (text) => setState(() {
                    if (selectedMcqOption == text) {
                      selectedMcqOption = null;
                    } else {
                      selectedMcqOption = text;
                    }
                  }),
            )
          else
            FillAnswerField(controller: answerController),

          const Spacer(),

          _buildSubmitButton(question, questions),
        ],
      ),
    );
  }

  Widget _buildQuestionText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
    );
  }

  _buildSubmitButton(QuestionModel question, List<QuestionModel> questions) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _submitAnswer(question, questions),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Submit Answer',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }

  void _submitAnswer(QuestionModel question, List<QuestionModel> questions) {
    final correctAnswer = question.correctAnswer.trim();
    final userAnswer =
        question.type == 'mcq'
            ? selectedMcqOption
            : answerController.text.trim();

    if (userAnswer == null || userAnswer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please answer the question before submitting.',
            style: TextStyle(fontSize: 14.sp),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final isCorrect = userAnswer == correctAnswer;
    if (!isCorrect) {
      context.read<AnswerCubit>().addWrongAnswer(
        WrongAnswerModel(
          id: null,
          questionText: question.questionText,
          correctAnswer: correctAnswer,
          userAnswer: userAnswer,
          level: question.level,
          skillId: question.skillId,
        ),
      );
      wrongAnswers.add(
        "Question: ${question.questionText}\nCorrect answer: ${question.correctAnswer}\nYour answer: $userAnswer",
      );
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: Text(
              isCorrect ? 'Correct!' : 'Wrong!',
              style: TextStyle(fontSize: 18.sp),
            ),
            content:
                isCorrect
                    ? Text('Good job!', style: TextStyle(fontSize: 16.sp))
                    : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Correct answer: $correctAnswer',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        if (question.explanation?.trim().isNotEmpty == true)
                          Text(
                            'Explanation: ${question.explanation}',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                      ],
                    ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _goToNextOrFinish(questions);
                },
                child: Text('OK', style: TextStyle(fontSize: 16.sp)),
              ),
            ],
          ),
    );
  }

  Future<void> _goToNextOrFinish(List<QuestionModel> questions) async {
    if (index < questions.length - 1) {
      setState(() {
        index++;
        selectedOptionId = null;
        answerController.clear();
        _loadOptionsIfNeeded();
      });
    } else {
      await context.read<AnswerCubit>().insertOrUpdateLevelStats(
        LevelStatsModel(
          id: null,
          level: questions.first.level,
          totalQuestions: questions.length,
          correctAnswers: questions.length - wrongAnswers.length,
          skillId: questions.first.skillId,
        ),
      );

      context.read<AnswerCubit>().loadLevelStats();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => QuizResult(
                skillId: questions.first.skillId,
                level: questions.first.level,
              ),
        ),
      );
    }
  }
}
