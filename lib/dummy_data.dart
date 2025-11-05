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
      questionText: 'Mengapa kutub magnet bumi tidak tetap?',
      options: [
        'Pengaruh rotasi bulan',
        'Perubahan inti bumi yang cair',
        'Pergeseran lempeng tektonik',
        'Variasi medan gravitasi matahari'
      ],
      correctAnswerIndex: 1,
      explanation: 'Kutub magnet bumi bergeser karena perubahan aliran besi cair di inti luar bumi yang menghasilkan medan magnet.',
    ),
    Question(
      id: '2',
      categoryId: '1',
      questionText: 'Mengapa es mengapung di atas air?',
      options: [
        'Karena massa jenis es lebih kecil',
        'Karena struktur kristal es yang ringan',
        'Karena tekanan udara di permukaan',
        'Karena kandungan udara dalam es'
      ],
      correctAnswerIndex: 0,
      explanation: 'Es memiliki massa jenis yang lebih kecil daripada air cair karena molekul air membentuk struktur kristal yang lebih renggang saat membeku.',
    ),
    Question(
      id: '3',
      categoryId: '1',
      questionText: 'Gas apakah yang paling banyak terdapat di atmosfer Bumi?',
      options: ['Oksigen', 'Karbon Dioksida', 'Nitrogen', 'Helium'],
      correctAnswerIndex: 2,
      explanation: 'Nitrogen menyusun sekitar 78% atmosfer Bumi.',
    ),
    Question(
      id: '4',
      categoryId: '1',
      questionText: 'Apa fungsi utama mitokondria dalam sel?',
      options: [
        'Regulasi tekanan osmosis',
        'Sintesis Protein',
        'Pencernaan intraseluler', 
        'Produksi energi (ATP)'
      ],
      correctAnswerIndex: 3,
      explanation: 'Mitokondria adalah "pembangkit tenaga" sel yang menghasilkan ATP melalui proses respirasi seluler.',
    ),
    Question(
      id: '5',
      categoryId: '1',
      questionText: 'Apa yang menyebabkan fenomena aurora?',
      options: [
        'Refleksi cahaya matahari di es kutub',
        'Partikel bermuatan dari matahari berinteraksi dengan atmosfer',
        'Pembakaran meteor di atmosfer',
        'Emisi cahaya dari gas mulia'
      ],
      correctAnswerIndex: 1,
      explanation: 'Aurora terjadi ketika partikel bermuatan dari angin matahari berinteraksi dengan medan magnet bumi dan atom di atmosfer.',
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
      questionText: 'Apa perbedaan utama antara HTTP dan HTTPS?',
      options: [
        'HTTPS lebih cepat daripada HTTP',
        'HTTPS menggunakan enkripsi SSL/TLS',
        'HTTP hanya untuk website statis',
        'HTTPS tidak memerlukan server'
      ],
      correctAnswerIndex: 1,
      explanation: 'HTTPS menggunakan enkripsi SSL/TLS untuk mengamankan komunikasi data, sedangkan HTTP mengirim data dalam bentuk plain text.',
    ),
    Question(
      id: '8',
      categoryId: '2',
       questionText: 'Manakah yang BUKAN termasuk database NoSQL?',
      options: ['PostgreSQL', 'Redis', 'MongoDB', 'Cassandra'],
      correctAnswerIndex: 0,
      explanation: 'PostgreSQL adalah database relational (SQL), sedangkan MongoDB, Redis, dan Cassandra adalah database NoSQL.',
    ),
    Question(
      id: '9',
      categoryId: '2',
       questionText: 'Apa yang dimaksud dengan "responsive design" dalam web development?',
      options: [
        'Website yang load dengan cepat',
        'Design yang berubah berdasarkan input user',
        'Website dengan banyak animasi',
        'Design yang menyesuaikan layout berdasarkan ukuran device'
      ],
      correctAnswerIndex: 3,
      explanation: 'Responsive design menggunakan CSS media queries untuk menyesuaikan layout website berdasarkan ukuran layar device.',
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
