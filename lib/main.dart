import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Tambahkan ini!
import 'package:etheramind/screens/splash_screen.dart';
import 'package:etheramind/providers/quiz_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => EtheramindProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EtheraMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Montserrat',
      ),
      home: const SplashScreen(),
    );
  }
}
