import 'package:flutter/material.dart';

class CharacterProvider with ChangeNotifier {
  int _selectedCharacterIndex = 0;

  int get selectedCharacterIndex => _selectedCharacterIndex;

  void selectCharacter(int index) {
    _selectedCharacterIndex = index;
    notifyListeners();
  }

  void reset(){
    _selectedCharacterIndex = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    reset();
    super.dispose();
  }
}
