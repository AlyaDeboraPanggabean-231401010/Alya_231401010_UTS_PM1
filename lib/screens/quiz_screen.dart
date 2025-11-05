

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; 
import 'package:etheramind/models/quiz_category.dart';
import 'package:etheramind/providers/quiz_provider.dart';
import 'package:etheramind/providers/theme_provider.dart';
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

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    final etheramindProvider = Provider.of<EtheramindProvider>(context, listen: false);
    etheramindProvider.startTimer();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final provider = Provider.of<EtheramindProvider>(context, listen: false);
      provider.updateTimer();
      
      if (provider.timeRemaining == 0) {
        _handleTimeUp(provider);
      }
    });
  }

  void _stopTimer() {
    final etheramindProvider = Provider.of<EtheramindProvider>(context, listen: false);
    etheramindProvider.stopTimer();
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
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

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background, // ✅ BACKGROUND THEME
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
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) => IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  QuestionCard(
                    question: currentQuestion.questionText,
                    questionNumber: currentQuestionIndex + 1,
                    totalQuestions: AppConstants.questionsPerCategory,
                  ),
                  
                  const SizedBox(height: 24),
                  
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
                  
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: currentQuestionIndex > 0 ? () {
                            etheramindProvider.previousQuestion();
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.surface, // ✅ THEME
                            foregroundColor: Theme.of(context).colorScheme.onSurface, // ✅ THEME
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
                            backgroundColor: Theme.of(context).colorScheme.primary, // ✅ THEME
                            foregroundColor: Theme.of(context).colorScheme.onPrimary, // ✅ THEME
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

  void _handleTimeUp(EtheramindProvider etheramindProvider) {
    final currentQuestionIndex = etheramindProvider.getCurrentQuestionIndex(widget.category.id);
    final isLastQuestion = currentQuestionIndex == AppConstants.questionsPerCategory - 1;

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
        backgroundColor: Theme.of(context).colorScheme.surface, // ✅ THEME
        title: Text(
          'Selesai Quiz?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface, // ✅ THEME
          ),
        ),
        content: Text(
          'Apakah Anda yakin ingin menyelesaikan quiz ini?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface, // ✅ THEME
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, // ✅ THEME
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToResults();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary, // ✅ THEME
            ),
            child: Text(
              'Ya, Selesai',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, // ✅ THEME
              ),
            ),
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

