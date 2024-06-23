import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:genesia/screens/character_profile_screen.dart';

class CharacterSelectionScreen extends StatefulWidget {
  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() =>
      _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  final List<String> characters = ["Alex", "Taylor", "Jordan", "Riley"];
  final List<String> descriptions = [
    "Alex is a supportive and encouraging friend. He is always there to lift you up and help you achieve your goals.",
    "Taylor is a knowledgeable mentor. He has a wealth of experience and wisdom to share on a variety of topics.",
    "Jordan is a fun and humorous companion. He is always ready to make you laugh and bring joy to your day.",
    "Riley is a thoughtful and empathetic listener. She provide a safe space for you to share your feelings and thoughts."
  ];

  final List<String> imagePaths = [
    "assets/alex.png",
    "assets/taylor.png",
    "assets/jordan.png",
    "assets/riley.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Character'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: characters.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Vibrate.feedback(FeedbackType.selection);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterProfileScreen(
                      character: characters[index],
                      description: descriptions[index],
                      index: index, imagePath: imagePaths[index],
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Image.asset( imagePaths[index]),
                    const SizedBox(height: 10),
                    Text(characters[index]),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
