import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  String _selectedCharacter = "Alex";

  @override
  void initState() {
    super.initState();
    _loadSelectedCharacter();
  }

  void _loadSelectedCharacter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCharacter = prefs.getString('selectedCharacter') ?? "Alex";
    });
  }

  void _sendMessage(String message) async {
    setState(() {
      _messages.add({"user": message});
    });
    _controller.clear();
    Vibrate.feedback(FeedbackType.selection);

    String prompt = "You are $_selectedCharacter. ";
    switch (_selectedCharacter) {
      case "Alex":
        prompt += "You are a supportive and encouraging friend. ";
        break;
      case "Taylor":
        prompt += "You are a knowledgeable mentor. ";
        break;
      case "Jordan":
        prompt += "You are a fun and humorous companion. ";
        break;
      case "Riley":
        prompt += "You are a thoughtful and empathetic listener. ";
        break;
    }
    prompt += "Respond to the following message: $message";

    // Call AI API
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
      headers: {
        'Authorization': 'Bearer YOUR_API_KEY',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "prompt": prompt,
        "max_tokens": 150,
        "temperature": 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _messages.add({"ai": data['choices'][0]['text']});
      });
      Vibrate.feedback(FeedbackType.success);
    } else {
      setState(() {
        _messages.add({"ai": "Sorry, I couldn't process that. Try again."});
      });
      Vibrate.feedback(FeedbackType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ListTile(
                    title: Text(
                      message.keys.first == "user" ? "You" : _selectedCharacter,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: message.keys.first == "user"
                            ? Colors.blue
                            : Colors.red,
                      ),
                    ),
                    subtitle: Text(message.values.first),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _sendMessage(_controller.text);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
