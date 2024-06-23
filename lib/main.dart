import 'package:flutter/material.dart';
import 'package:genesia/screens/character_selection_screen.dart';
import 'package:genesia/screens/chat_screen.dart';
import 'package:genesia/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genesia App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/':  (context) => const OnboardingScreen(),
        '/characterSelection': (context) => const CharacterSelectionScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
