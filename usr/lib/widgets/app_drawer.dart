import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  Widget _buildDrawerItem(IconData icon, String title, String identifier) {
    return ListTile(
      leading: Icon(icon, size: 26, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      onTap: () {
        onSelectScreen(identifier);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1F1F1F),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'IntelliSheet AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your AI Study Assistant',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.dashboard, 'Dashboard', 'home'),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
              child: Text('Generators', style: TextStyle(color: Colors.white54)),
            ),
            _buildDrawerItem(Icons.school, 'Academic Notes', 'academic_notes'),
            _buildDrawerItem(Icons.military_tech, 'Competitive Exam Notes', 'competitive_notes'),
            _buildDrawerItem(Icons.functions, 'Formula Sheets', 'formula_sheet'),
            _buildDrawerItem(Icons.quiz, 'Test Generator', 'test_generator'),
            _buildDrawerItem(Icons.model_training, 'Practice Session', 'practice_session'),
            const Divider(),
             const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
              child: Text('Tools', style: TextStyle(color: Colors.white54)),
            ),
            _buildDrawerItem(Icons.video_library, 'One-Shot Videos', 'video_finder'),
            _buildDrawerItem(Icons.support_agent, 'Teacher\'s Help', 'teachers_help'),
            _buildDrawerItem(Icons.calculate, 'Calculator', 'calculator'),
          ],
        ),
      ),
    );
  }
}
