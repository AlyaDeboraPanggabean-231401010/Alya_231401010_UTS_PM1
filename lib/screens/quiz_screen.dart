import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etheramind/models/quiz_category.dart';
import 'package:etheramind/providers/quiz_provider.dart';
import 'package:etheramind/utils/constants.dart';
import 'package:etheramind/widgets/question_card.dart';
import 'package:etheramind/widgets/option_button.dart';
import 'package:etheramind/widgets/timer_widget.dart';
import 'package:etheramind/screens/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizCategory category;

  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  late AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _startTimer();
  }

  void _startTimer() {
    final etheramindProvider = Provider.of<EtheramindProvider>(context, listen: false);
    etheramindProvider.startTimer();
    _timerController.repeat();
  }

  void _stopTimer() {
    final etheramindProvider = Provider.of<EtheramindProvider>(context, listen: false);
    etheramindProvider.stopTimer();
    _timerController.stop();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EtheramindProvider>(
      builder: (context, etheramindProvider, child) {
        final questions = etheramindProvider.getQuestionsForCategory(widget.category.id);
        final currentQuestionIndex = etheramindProvider.getCurrentQuestionIndex(widget.category.id);
        final currentQuestion = questions[currentQuestionIndex];
        final userAnswer = etheramindProvider.getUserAnswer(widget.category.id, currentQuestionIndex);
        final isLastQuestion = currentQuestionIndex == AppConstants.questionsPerCategory - 1;

        // Timer listener
        _timerController.addListener(() {
          etheramindProvider.updateTimer();
          if (etheramindProvider.timeRemaining == 0) {
            _handleTimeUp(etheramindProvider, currentQuestionIndex, isLastQuestion);
          }
        });

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.category.name),
            backgroundColor: widget.category.color,
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimerWidget(
                  timeRemaining: etheramindProvider.timeRemaining,
                  size: 40,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Question Card
                  QuestionCard(
                    question: currentQuestion.questionText,
                    questionNumber: currentQuestionIndex + 1,
                    totalQuestions: AppConstants.questionsPerCategory,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Options
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: OptionButton(
                            text: currentQuestion.options[index],
                            index: index,
                            isSelected: userAnswer == index,
                            isCorrect: index == currentQuestion.correctAnswerIndex,
                            showAnswer: false,
                            onTap: () {
                              etheramindProvider.answerQuestion(currentQuestionIndex, index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Navigation Buttons
                  Row(
                    children: [
                      // Previous Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: currentQuestionIndex > 0 ? () {
                            etheramindProvider.previousQuestion();
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.grey[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Sebelumnya',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Next/Submit Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: userAnswer != -1 ? () {
                            if (isLastQuestion) {
                              _stopTimer();
                              _showSubmitDialog(etheramindProvider);
                            } else {
                              etheramindProvider.nextQuestion();
                            }
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isLastQuestion ? 'Selesai' : 'Selanjutnya',
                            style: const TextStyle(fontFamily: 'Montserrat'),
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
      },
    );
  }

  void _handleTimeUp(EtheramindProvider etheramindProvider, int currentQuestionIndex, bool isLastQuestion) {
    // Auto-submit empty answer if time's up
    etheramindProvider.answerQuestion(currentQuestionIndex, -1);
    
    if (isLastQuestion) {
      _stopTimer();
      _navigateToResults();
    } else {
      etheramindProvider.nextQuestion();
    }
  }

  void _showSubmitDialog(EtheramindProvider etheramindProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selesai Quiz?'),
        content: const Text('Apakah Anda yakin ingin menyelesaikan quiz ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToResults();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Ya, Selesai'),
          ),
        ],
      ),
    );
  }

  void _navigateToResults() {
    _stopTimer();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(category: widget.category),
      ),
    );
  }
}