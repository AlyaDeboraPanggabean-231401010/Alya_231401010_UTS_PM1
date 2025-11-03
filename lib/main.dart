import 'package:flutter/material.dart';
import 'package:etheramind/screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: ubah ke MultiProvider + Consumer<ThemeProvider> nanti
    return MaterialApp(
      title: 'EtheraMind',
      debugShowCheckedModeBanner: false,
      // TODO: nanti ganti dengan light/dark theme
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Montserrat',
      ),
      home: const SplashScreen(),
    );
  }
}
