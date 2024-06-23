import 'package:flutter/material.dart';
import 'package:genesia/providers/character_provider.dart';
import 'package:provider/provider.dart';

class CharacterCard extends StatelessWidget {
  final int index;

  const CharacterCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);
    final isSelected = characterProvider.selectedCharacterIndex == index;

    return GestureDetector(
      onTap: () {
        characterProvider.selectCharacter(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.7) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: isSelected
              ? [const BoxShadow(color: Colors.blue, blurRadius: 10)]
              : [const BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/character${index + 1}.png', height: 100),
            const SizedBox(height: 10),
            Text(
              'Character ${index + 1}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
