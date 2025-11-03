import 'package:flutter/material.dart';
import 'package:couldai_user_app/widgets/app_drawer.dart';
import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/screens/academic_notes_generator_screen.dart';
import 'package:couldai_user_app/screens/competitive_exam_notes_generator_screen.dart';
import 'package:couldai_user_app/screens/formula_sheet_generator_screen.dart';
import 'package:couldai_user_app/screens/test_generator_screen.dart';
import 'package:couldai_user_app/screens/practice_session_generator_screen.dart';
import 'package:couldai_user_app/screens/video_finder_screen.dart';
import 'package:couldai_user_app/screens/teachers_help_screen.dart';
import 'package:couldai_user_app/screens/calculator_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _currentScreen = const HomeScreen();
  String _currentTitle = 'IntelliSheet Dashboard';

  void _selectScreen(String identifier) {
    Widget screen;
    String title;
    switch (identifier) {
      case 'home':
        screen = const HomeScreen();
        title = 'IntelliSheet Dashboard';
        break;
      case 'academic_notes':
        screen = const AcademicNotesGeneratorScreen();
        title = 'Academic Notes Generator';
        break;
      case 'competitive_notes':
        screen = const CompetitiveExamNotesGeneratorScreen();
        title = 'Competitive Exam Notes';
        break;
      case 'formula_sheet':
        screen = const FormulaSheetGeneratorScreen();
        title = 'Formula Sheet Generator';
        break;
      case 'test_generator':
        screen = const TestGeneratorScreen();
        title = 'Test Generator';
        break;
      case 'practice_session':
        screen = const PracticeSessionGeneratorScreen();
        title = 'Practice Session';
        break;
      case 'video_finder':
        screen = const VideoFinderScreen();
        title = 'One-Shot Video Finder';
        break;
      case 'teachers_help':
        screen = const TeachersHelpScreen();
        title = 'Teacher\'s Help';
        break;
      case 'calculator':
        screen = const CalculatorScreen();
        title = 'Calculator';
        break;
      default:
        screen = const HomeScreen();
        title = 'IntelliSheet Dashboard';
    }
    setState(() {
      _currentScreen = screen;
      _currentTitle = title;
    });
    Navigator.of(context).pop(); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
        centerTitle: true,
      ),
      drawer: AppDrawer(onSelectScreen: _selectScreen),
      body: _currentScreen,
    );
  }
}
