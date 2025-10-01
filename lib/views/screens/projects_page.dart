import 'package:flutter/material.dart';
import '../base/glitch_text.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  final projects = const [
    {"name": "GroceryMaster", "desc": "Flutter grocery app with Firebase backend"},
    {"name": "Labour Booking App", "desc": "Cross-platform labor management system"},
    {"name": "Car Rental App", "desc": "Flutter car rental UI with animations"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlitchText(
            text: "Projects",
            textStyle: TextStyle(fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.bold),
            randomLetterSwitch: true,
            glitchUpDown: true,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: projects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                final proj = projects[index];
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.greenAccent, width: 1),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlitchText(
                          text: proj['name']!,
                          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          randomLetterSwitch: true,
                          glitchUpDown: true,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          proj['desc']!,
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
