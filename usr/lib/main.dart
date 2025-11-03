import 'package:flutter/material.dart';

void main() {
  runApp(const IntelliSheetApp());
}

class IntelliSheetApp extends StatelessWidget {
  const IntelliSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliSheet: AI Cheat Sheet Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _topicController = TextEditingController();
  String _selectedCategory = 'Programming';
  final List<String> _categories = ['Programming', 'Math', 'Science', 'History', 'Languages'];

  void _generateCheatSheet() {
    if (_topicController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a topic')),
      );
      return;
    }

    // Mock cheat sheet generation (replace with real AI integration later)
    final mockCheatSheet = _generateMockCheatSheet(_topicController.text, _selectedCategory);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheatSheetScreen(
          topic: _topicController.text,
          category: _selectedCategory,
          cheatSheet: mockCheatSheet,
        ),
      ),
    );
  }

  Map<String, dynamic> _generateMockCheatSheet(String topic, String category) {
    // Mock data - in a real app, this would call an AI service
    return {
      'title': '$topic Cheat Sheet',
      'sections': [
        {
          'heading': 'Key Concepts',
          'content': '• Concept 1: Brief explanation\n• Concept 2: Brief explanation\n• Concept 3: Brief explanation',
        },
        {
          'heading': 'Important Formulas/Syntax',
          'content': '• Formula 1: Example\n• Formula 2: Example',
        },
        {
          'heading': 'Tips & Tricks',
          'content': '• Tip 1: Useful advice\n• Tip 2: Helpful hint',
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IntelliSheet Generator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Generate Your AI Cheat Sheet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _topicController,
              decoration: const InputDecoration(
                labelText: 'Enter Topic (e.g., Python Functions)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Select Category',
                border: OutlineInputBorder(),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateCheatSheet,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Generate Cheat Sheet'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }
}

class CheatSheetScreen extends StatelessWidget {
  final String topic;
  final String category;
  final Map<String, dynamic> cheatSheet;

  const CheatSheetScreen({
    super.key,
    required this.topic,
    required this.category,
    required this.cheatSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$topic Cheat Sheet'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cheatSheet['title'],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: $category',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ...(cheatSheet['sections'] as List).map((section) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section['heading'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      section['content'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Generate Another'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}