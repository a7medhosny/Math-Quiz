import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_quiz/feature/answer/logic/cubit/answer_cubit.dart';
import 'package:math_quiz/feature/question/logic/cubit/question_cubit.dart';

import '../../../quiz/ui/screens/quiz_screen.dart';

class QuestionCreation extends StatefulWidget {
  const QuestionCreation({super.key, required this.skillId});
  final int skillId;
  @override
  State<QuestionCreation> createState() => _QuestionCreationState();
}

class _QuestionCreationState extends State<QuestionCreation> {
  int difficultySelectedIndex = -1;
  int questionCountSelectedIndex = -1;

  final List<String> difficulties = ["Easy", "Medium", "Hard"];
  final List<String> questionCounts = ["5", "10", "15", "20"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Quiz', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Difficulty Level"),
            const SizedBox(height: 16),
            _buildOptionsListView(
              items: difficulties,
              selectedIndex: difficultySelectedIndex,
              onTap: (index) => setState(() => difficultySelectedIndex = index),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle("Number of Questions"),
            const SizedBox(height: 16),
            _buildOptionsListView(
              items: questionCounts,
              selectedIndex: questionCountSelectedIndex,
              onTap:
                  (index) => setState(() => questionCountSelectedIndex = index),
            ),
            const Spacer(),
            _buildStartQuizButton(
              text: 'Start Quiz',
              level:
                  difficultySelectedIndex != -1
                      ? difficulties[difficultySelectedIndex].toLowerCase()
                      : "",
              skillId: widget.skillId,
              limit:
                  questionCountSelectedIndex != -1
                      ? int.parse(questionCounts[questionCountSelectedIndex])
                      : 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildOptionsListView({
    required List<String> items,
    required int selectedIndex,
    required void Function(int) onTap,
  }) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color:
                    selectedIndex == index
                        ? Colors.deepPurple[200]
                        : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  items[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStartQuizButton({
    required String text,
    required String level,
    required int skillId,
    required int limit,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (difficultySelectedIndex == -1 ||
              questionCountSelectedIndex == -1) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please select both difficulty level and number of questions',
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }

          context.read<QuestionCubit>().loadSQuestions(
            level: level,
            skillId: skillId,
            limit: limit,
          );
          context.read<AnswerCubit>().deleteWrongAnswersByLevel(
            level: level,
            skillId: skillId,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QuizScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
