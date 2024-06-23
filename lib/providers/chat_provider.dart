import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatProvider with ChangeNotifier {
  final List<Map<String, String>> _messages = [];

  List<Map<String, String>> get messages => _messages;

  void addMessage(String role, String content) {
    _messages.add({'role': role, 'content': content});
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    addMessage('user', message);

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_OPENAI_API_KEY',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': _messages.map((msg) {
          return {'role': msg['role'], 'content': msg['content']};
        }).toList(),
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'];
      addMessage('bot', content);
    } else {
      addMessage('bot', 'Error: Unable to get a response.');
    }
  }
}
