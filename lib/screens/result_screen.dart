import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etheramind/models/quiz_category.dart';
import 'package:etheramind/providers/quiz_provider.dart';
import 'package:etheramind/utils/constants.dart';
import 'package:etheramind/widgets/result_card.dart';
import 'package:etheramind/widgets/option_button.dart';
import 'package:etheramind/screens/category_screen.dart';
import 'package:etheramind/screens/quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final QuizCategory category;

  const ResultScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final etheramindProvider = Provider.of<EtheramindProvider>(context);
    final questions = etheramindProvider.getQuestionsForCategory(category.id);
    final score = etheramindProvider.getScoreForCategory(category.id);
    final percentage = (score / AppConstants.questionsPerCategory) * 100;

    String getPerformanceText() {
      if (percentage >= 80) return 'Luar Biasa! 🎉';
      if (percentage >= 60) return 'Bagus! 👍';
      if (percentage >= 40) return 'Cukup 👌';
      return 'Perlu belajar lagi 📚';
    }

    Color getPerformanceColor() {
      if (percentage >= 80) return Colors.green;
      if (percentage >= 60) return Colors.orange;
      return Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Quiz'),
        backgroundColor: category.color,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Result Summary
              ResultCard(
                categoryName: category.name,
                score: score,
                totalQuestions: AppConstants.questionsPerCategory,
                icon: Icons.quiz,
                color: category.color,
              ),
              
              const SizedBox(height: 24),
              
              // Performance Message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: getPerformanceColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: getPerformanceColor()),
                ),
                child: Column(
                  children: [
                    Text(
                      getPerformanceText(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: getPerformanceColor(),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Anda menjawab $score dari ${AppConstants.questionsPerCategory} pertanyaan dengan benar',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Review Answers Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Review Jawaban:',
                        style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground,
                     ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          final question = questions[index];
                          final userAnswer = etheramindProvider.getUserAnswer(category.id, index);
                          final isCorrect = userAnswer == question.correctAnswerIndex;
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: isCorrect ? Colors.green : Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            isCorrect ? Icons.check : Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Pertanyaan ${index + 1}',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    question.questionText,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ...question.options.asMap().entries.map((entry) {
                                    final optionIndex = entry.key;
                                    final optionText = entry.value;
                                    final isUserAnswer = userAnswer == optionIndex;
                                    final isCorrectAnswer = optionIndex == question.correctAnswerIndex;
                                    
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: OptionButton(
                                        text: optionText,
                                        index: optionIndex,
                                        isSelected: isUserAnswer,
                                        isCorrect: isCorrectAnswer,
                                        showAnswer: true,
                                        onTap: () {},
                                      ),
                                    );
                                  }),
                                  if (!isCorrect) ...[
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb_outline,
                                            color: Colors.green,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'Penjelasan: ${question.explanation}',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // Action Buttons
              Row(
                children: [
                Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          etheramindProvider.resetQuiz();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const CategoryScreen()),
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Quiz Lainnya',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        etheramindProvider.setCurrentCategory(category.id);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(category: category),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Ulangi Quiz',
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}