import 'package:flutter/material.dart';
import 'package:etheramind/models/quiz_category.dart';
import 'package:etheramind/models/question.dart';
import 'package:etheramind/models/user.dart';
import 'package:etheramind/utils/constants.dart';
import 'package:etheramind/dummy_data.dart';

class EtheramindProvider with ChangeNotifier {
  User? _user;
  List<QuizCategory> _categories = [];
  List<Question> _questions = [];
  Map<String, List<int>> _userAnswers = {};
  Map<String, int> _currentQuestionIndex = {};
  Map<String, int> _scores = {};
  String? _currentCategoryId;
  int _timeRemaining = AppConstants.quizTimerSeconds;
  bool _isTimerRunning = false;

  User? get user => _user;
  List<QuizCategory> get categories => _categories;
  List<Question> get questions => _questions;
  int get timeRemaining => _timeRemaining;
  bool get isTimerRunning => _isTimerRunning;

  EtheramindProvider() {
    _initializeData();
  }

  void _initializeData() {
    _categories = DummyData.categories;
    _questions = DummyData.questions;

    for (var category in _categories) {
      _userAnswers[category.id] =
          List.filled(AppConstants.questionsPerCategory, -1);
      _currentQuestionIndex[category.id] = 0;
      _scores[category.id] = 0;
    }
  }

  void setUserName(String name) {
    _user = User(name: name);
    notifyListeners();
  }

  void setCurrentCategory(String categoryId) {
    _currentCategoryId = categoryId;
    _timeRemaining = AppConstants.quizTimerSeconds;
    _currentQuestionIndex[categoryId] = 0;
    notifyListeners();
  }

  void resetCategory(String categoryId) {
    _userAnswers[categoryId] = List.filled(AppConstants.questionsPerCategory, -1);
    _currentQuestionIndex[categoryId] = 0;
    _scores[categoryId] = 0;
    _timeRemaining = AppConstants.quizTimerSeconds;
    _isTimerRunning = false;
    notifyListeners();
  }

  List<Question> getQuestionsForCategory(String categoryId) {
    return _questions
        .where((question) => question.categoryId == categoryId)
        .toList();
  }

  void answerQuestion(int questionIndex, int selectedOption) {
    if (_currentCategoryId == null) return;
    
    // Simpan jawaban user
    _userAnswers[_currentCategoryId!]![questionIndex] = selectedOption;
    
    // HITUNG ULANG SEMUA SKOR
    _calculateScoreForCurrentCategory();
    
    notifyListeners();
  }

  // METHOD: Hitung skor dari scratch
  void _calculateScoreForCurrentCategory() {
    if (_currentCategoryId == null) return;
    
    final currentQuestions = getQuestionsForCategory(_currentCategoryId!);
    int newScore = 0;
    
    for (int i = 0; i < currentQuestions.length; i++) {
      final userAnswer = _userAnswers[_currentCategoryId!]![i];
      if (userAnswer != -1 && userAnswer == currentQuestions[i].correctAnswerIndex) {
        newScore++;
      }
    }
    
    _scores[_currentCategoryId!] = newScore;
  }

  void nextQuestion() {
    if (_currentCategoryId == null) return;

    final currentIndex = _currentQuestionIndex[_currentCategoryId!] ?? 0;
    if (currentIndex < AppConstants.questionsPerCategory - 1) {
      _currentQuestionIndex[_currentCategoryId!] = currentIndex + 1;
      _timeRemaining = AppConstants.quizTimerSeconds;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentCategoryId == null) return;

    final currentIndex = _currentQuestionIndex[_currentCategoryId!] ?? 0;
    if (currentIndex > 0) {
      _currentQuestionIndex[_currentCategoryId!] = currentIndex - 1;
      _timeRemaining = AppConstants.quizTimerSeconds;
      notifyListeners();
    }
  }

  int getCurrentQuestionIndex(String categoryId) {
    return _currentQuestionIndex[categoryId] ?? 0;
  }

  int? getUserAnswer(String categoryId, int questionIndex) {
    return _userAnswers[categoryId]?[questionIndex];
  }

  int getScoreForCategory(String categoryId) {
    return _scores[categoryId] ?? 0;
  }

  void startTimer() {
    _isTimerRunning = true;
    notifyListeners();
  }

  void stopTimer() {
    _isTimerRunning = false;
    notifyListeners();
  }

  void updateTimer() {
    if (_isTimerRunning && _timeRemaining > 0) {
      _timeRemaining--;
      notifyListeners();

      if (_timeRemaining == 0) {
        _isTimerRunning = false;
        notifyListeners();
      }
    }
  }

  void resetTimer() {
    _timeRemaining = AppConstants.quizTimerSeconds;
    _isTimerRunning = false;
    notifyListeners();
  }

  void resetQuiz() {
    _initializeData();
    _timeRemaining = AppConstants.quizTimerSeconds;
    _isTimerRunning = false;
    _currentCategoryId = null;
    notifyListeners();
  }
}