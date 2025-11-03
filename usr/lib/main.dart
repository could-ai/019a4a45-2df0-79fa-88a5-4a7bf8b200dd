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
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
  final List<String> _categories = ['Programming', 'Math', 'Science', 'History', 'Languages', 'General Knowledge'];

  void _generateCheatSheet() {
    if (_topicController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a topic to generate a cheat sheet.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Mock cheat sheet generation
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
    return {
      'title': '$topic Cheat Sheet',
      'sections': [
        {
          'heading': 'Key Concepts & Definitions',
          'content': '• Concept A: A detailed explanation of the first key concept.\n• Concept B: A detailed explanation of the second key concept.\n• Concept C: A detailed explanation of the third key concept.',
        },
        {
          'heading': 'Core Formulas / Syntax',
          'content': '• Formula/Syntax 1: Description and example usage.\n• Formula/Syntax 2: Description and example usage.',
        },
        {
          'heading': 'Practical Examples',
          'content': '• Example 1: A step-by-step example demonstrating a key concept.\n• Example 2: Another practical example to solidify understanding.',
        },
        {
          'heading': 'Common Mistakes & Tips',
          'content': '• Mistake 1: A common pitfall to avoid.\n• Tip 1: A useful trick or best practice to remember.',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.auto_awesome, size: 60, color: Colors.deepPurple),
              const SizedBox(height: 16),
              const Text(
                'Create Your AI-Powered Cheat Sheet',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter a topic and select a category to instantly generate a concise summary.',
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _topicController,
                decoration: const InputDecoration(
                  labelText: 'Enter Topic (e.g., "Python Dictionaries")',
                  prefixIcon: Icon(Icons.topic),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _generateCheatSheet,
                icon: const Icon(Icons.bolt),
                label: const Text('Generate Cheat Sheet'),
              ),
            ],
          ),
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
    final sections = cheatSheet['sections'] as List;

    return Scaffold(
      appBar: AppBar(
        title: Text(cheatSheet['title']),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing functionality coming soon!')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section['heading'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    section['content'],
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        tooltip: 'Generate Another',
        child: const Icon(Icons.add),
      ),
    );
  }
}
