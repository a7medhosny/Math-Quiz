import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_quiz/feature/quiz/logic/cubit/mcq_options_cubit.dart';

class McqOptions extends StatelessWidget {
  final int? selectedOptionId;
  final Function(int?) onOptionSelected;
  final Function(String) onMcqTextSelected;

  const McqOptions({
    super.key,
    required this.selectedOptionId,
    required this.onOptionSelected,
    required this.onMcqTextSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<McqOptionsCubit, McqOptionsState>(
      builder: (context, state) {
        if (state is McqOptionsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is McqOptionsLoaded) {
          final options = state.mcqOptions;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = selectedOptionId == option.id;

                    return GestureDetector(
                      onTap: () {
                        onMcqTextSelected(option.optionText);
                        onOptionSelected(option.id);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.deepPurple[100]
                                  : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.deepPurple : Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          option.optionText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                isSelected ? Colors.deepPurple : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is McqOptionsError) {
          return Text(state.message, style: const TextStyle(color: Colors.red));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
