import 'package:flutter/material.dart';
import 'package:etheramind/models/quiz_category.dart';
import 'package:etheramind/models/question.dart';

class DummyData {
  static final List<QuizCategory> categories = [
    QuizCategory(
    id: '1',
    name: 'Sains',
    description: 'Pengetahuan Umum Tentang Sains',
    icon: 'assets/images/sains.logo.png',
    colorValue: Colors.blue.value,
    title: 'Kuis Sains',
   
  ),
  QuizCategory(
    id: '2',
    name: 'Teknologi',
    description: 'Teknologi dan Pemrograman',
    icon: 'assets/images/Teknologi.png',
    colorValue: Colors.purple.value,
    title: 'Kuis Teknologi',
   
  ),

  ];

  static final List<Question> questions = [
    // Sains Questions (5 questions)
    Question(
      id: '1',
      categoryId: '1',
      questionText: 'Planet manakah yang dikenal sebagai Planet Merah?',
      options: ['Venus', 'Mars', 'Jupiter', 'Saturnus'],
      correctAnswerIndex: 1,
      explanation: 'Mars dikenal sebagai Planet Merah karena permukaannya yang berwarna kemerahan.',
    ),
    Question(
      id: '2',
      categoryId: '1',
      questionText: 'Berapakah jumlah tulang dalam tubuh manusia dewasa?',
      options: ['196', '206', '216', '226'],
      correctAnswerIndex: 1,
      explanation: 'Tubuh manusia dewasa memiliki 206 tulang.',
    ),
    Question(
      id: '3',
      categoryId: '1',
      questionText: 'Gas apakah yang paling banyak terdapat di atmosfer Bumi?',
      options: ['Oksigen', 'Nitrogen', 'Karbon Dioksida', 'Helium'],
      correctAnswerIndex: 1,
      explanation: 'Nitrogen menyusun sekitar 78% atmosfer Bumi.',
    ),
    Question(
      id: '4',
      categoryId: '1',
      questionText: 'Proses fotosintesis menghasilkan...',
      options: ['Oksigen', 'Karbon Dioksida', 'Nitrogen', 'Helium'],
      correctAnswerIndex: 0,
      explanation: 'Fotosintesis menghasilkan oksigen dan glukosa.',
    ),
    Question(
      id: '5',
      categoryId: '1',
      questionText: 'Binatang manakah yang termasuk mamalia?',
      options: ['Ikan Paus', 'Buaya', 'Burung', 'Ular'],
      correctAnswerIndex: 0,
      explanation: 'Ikan paus adalah mamalia karena menyusui anaknya.',
    ),

    // Teknologi Questions (5 questions)
    Question(
      id: '6',
      categoryId: '2',
      questionText: 'Bahasa pemrograman apakah yang digunakan untuk pengembangan aplikasi Flutter?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctAnswerIndex: 2,
      explanation: 'Flutter menggunakan bahasa pemrograman Dart.',
    ),
    Question(
      id: '7',
      categoryId: '2',
      questionText: 'Apa kepanjangan dari HTML?',
      options: [
        'Hyper Text Markup Language',
        'High Tech Modern Language',
        'Hyper Transfer Markup Language',
        'High Text Modern Language'
      ],
      correctAnswerIndex: 0,
      explanation: 'HTML adalah Hyper Text Markup Language.',
    ),
    Question(
      id: '8',
      categoryId: '2',
      questionText: 'Manakah yang bukan termasuk sistem operasi?',
      options: ['Windows', 'Linux', 'Python', 'macOS'],
      correctAnswerIndex: 2,
      explanation: 'Python adalah bahasa pemrograman, bukan sistem operasi.',
    ),
    Question(
      id: '9',
      categoryId: '2',
      questionText: 'Apa fungsi utama dari CSS?',
      options: [
        'Menambah interaksi website',
        'Mengatur tampilan dan style',
        'Menyimpan data',
        'Memproses logika bisnis'
      ],
      correctAnswerIndex: 1,
      explanation: 'CSS digunakan untuk mengatur tampilan dan style website.',
    ),
    Question(
      id: '10',
      categoryId: '2',
      questionText: 'Apa yang dimaksud dengan API?',
      options: [
        'Application Programming Interface',
        'Advanced Programming Interface',
        'Application Process Integration',
        'Advanced Process Integration'
      ],
      correctAnswerIndex: 0,
      explanation: 'API adalah Application Programming Interface.',
    ),
  ];
}
