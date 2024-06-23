import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterProfileScreen extends StatelessWidget {
  final String character;
  final String description;
  final String imagePath;
  final int index;

  const CharacterProfileScreen({
    super.key,
    required this.character,
    required this.description,
    required this.imagePath,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(imagePath, height: 200),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                character,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('selectedCharacter', character);
                    Navigator.pushReplacementNamed(context, '/chat');
                  });
                },
                child: Text('Select $character'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
