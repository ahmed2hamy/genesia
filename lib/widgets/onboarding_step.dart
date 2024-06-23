import 'package:flutter/material.dart';

class OnboardingStep extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastStep;
  final VoidCallback? onButtonPressed;

  const OnboardingStep({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isLastStep = false,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(imagePath),
      //     fit: BoxFit.contain,
      //   ),
      // ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          if (isLastStep) const SizedBox(height: 20),
          if (isLastStep)
            ElevatedButton(
              onPressed: onButtonPressed,
              child: const Text('Get Started'),
            ),
        ],
      ),
    );
  }
}
