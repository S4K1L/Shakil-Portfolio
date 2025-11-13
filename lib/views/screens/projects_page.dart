import 'package:flutter/material.dart';
import 'package:s4k1l/views/base/project_grid.dart';
import 'package:url_launcher/url_launcher.dart';
import '../base/glitch_text.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
final List<Map<String, dynamic>> projects = const [
  {
    "name": "Chakra Quiz",
    "desc": "A calming chakra assessment app with interactive quizzes.",
    "image": "assets/projects/chakra.png",
    "tech": [
      "Flutter",
      "Django REST Framework",
      "GetX",
      "SharedPreferences",
    ],
    "features": [
      "Interactive chakra quiz with scoring",
      "Personalized results + tips",
      "Local progress persistence",
    ],
    "github": "https://github.com/S4K1L/Kunchi-Hidup.git",
  },
  {
    "name": "The Clue",
    "desc": "A modern crypto learning app with bite-sized lessons.",
    "image": "assets/projects/theClue.png",
    "tech": [
      "Flutter",
      "Django REST Framework",
      "GetX",
      "SharedPreferences",
    ],
    "features": [
      "Guided learning modules",
      "Progress tracking & quizzes",
      "Offline lesson caching",
    ],
    "github": "https://github.com/S4K1L/Crypto-Education.git",
  },
  {
    "name": "App Rolling",
    "desc": "A sleek car rental UI concept with live tracking.",
    "image": "assets/projects/uber.png",
    "tech": [
      "Flutter",
      "Node.js REST API",
      "GetX",
      "SharedPreferences",
    ],
    "features": [
      "Real-time vehicle tracking",
      "Animated booking flow",
      "Booking history & receipts",
    ],
    "github": "https://github.com/S4K1L/Uber.git",
  },
  {
    "name": "Map’d",
    "desc": "A smart travel companion with AI route planning.",
    "image": "assets/projects/mapd.png",
    "tech": [
      "Flutter",
      "Django REST Framework",
      "GetX",
      "SharedPreferences",
    ],
    "features": [
      "Offline maps & navigation",
      "AI trip suggestions",
      "Community chat & recommendations",
    ],
    "store": "https://play.google.com/store/apps/details?id=com.wanderlink.app",
    "github": "https://github.com/S4K1L/Mapd.git",
  },
  {
    "name": "re:",
    "desc": "A next-gen social app for authentic sharing.",
    "image": "assets/projects/re.png",
    "tech": [
      "Flutter",
      "Django REST Framework",
      "GetX",
      "SharedPreferences",
    ],
    "features": [
      "Real-time chatting",
      "Smart video reaction shares",
      "Auto delete of old media in 48 hours",
    ],
    "github": "https://github.com/S4K1L/REE-Social-Media.git",
  },
];


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    for (var project in projects) {
      await precacheImage(AssetImage(project['image']), context);
    }
  }

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
