import 'package:flutter/material.dart';
import 'package:s4k1l/views/base/project_grid.dart';
import 'package:url_launcher/url_launcher.dart';
import '../base/glitch_text.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  final List<Map<String, dynamic>> projects = const [
    {
      "name": "Chakra Quiz",
      "desc":
          "A calming and interactive Chakra Quiz Application built with Flutter for the frontend, powered by a Django REST API backend, and managed with GetX for smooth state handling. Designed to help users explore their energy balance and self-awareness through chakra-based quizzes.",
      "image": "assets/projects/chakra.png",
      "tech": [
        "Flutter",
        "Django REST Framework",
        "GetX",
        "SharedPreferences",
        "Dart Language",
        "Python Language",
      ],
      "github": "https://github.com/S4K1L/Kunchi-Hidup.git",
    },
    {
      "name": "The Clue",
      "desc":
          "A modern Crypto Learning Application built with Flutter for a smooth cross-platform experience, powered by a Django REST API backend, and managed with GetX for state management and navigation. Designed to help users learn, track, and stay updated on cryptocurrency knowledge, markets, and news.",
      "image": "assets/projects/theClue.png",
      "tech": [
        "Flutter",
        "Django REST Framework",
        "GetX",
        "SharedPreferences",
        "Dart Language",
        "Python Language",
      ],
      "github": "https://github.com/S4K1L/Crypto-Education.git",
    },
    {
      "name": "App Rolling",
      "desc":
          "Modern animated Flutter car rental UI with RESTApi backend, sleek transitions, and real-time live location system.",
      "image": "assets/projects/uber.png",
      "tech": [
        "Flutter",
        "NodeJS REST Framework",
        "GetX",
        "SharedPreferences",
        "Dart Language",
        "JavaScript Language",
      ],
      "github": "https://github.com/S4K1L/Uber.git",
    },
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlitchText(
            text: "Projects",
            textStyle: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            randomLetterSwitch: true,
            glitchUpDown: true,
          ),
          const SizedBox(height: 20),

          // Project Grid
          ProjectsGrid(
            projects: projects,
            isMobile: MediaQuery.of(context).size.width < 600,
            onGitHubTap: (url) => _launchUrl(url),
          ),
        ],
      ),
    );
  }
}
