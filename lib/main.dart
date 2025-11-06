import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:etheramind/screens/splash_screen.dart';
import 'package:etheramind/providers/quiz_provider.dart';
import 'package:etheramind/providers/theme_provider.dart';
import 'package:etheramind/utils/theme.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EtheramindProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>( 
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'EtheraMind',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme, 
          darkTheme: AppTheme.darkTheme,
          home: const SplashScreen(), 
        );
      },
    );
  }
}
