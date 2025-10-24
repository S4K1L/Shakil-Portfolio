import 'package:flutter/material.dart';
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
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: projects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile ? 1.1 : 1.5,
              ),
              itemBuilder: (context, index) {
                final proj = projects[index];
                return _AnimatedProjectCard(
                  name: proj["name"] as String,
                  desc: proj["desc"] as String,
                  image: proj["image"] as String,
                  tech: List<String>.from(proj["tech"] as List),
                  github: proj["github"] as String,
                  onGitHubTap: () => _launchUrl(proj["github"] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedProjectCard extends StatefulWidget {
  final String name;
  final String desc;
  final String image;
  final List<String> tech;
  final String github;
  final VoidCallback onGitHubTap;

  const _AnimatedProjectCard({
    required this.name,
    required this.desc,
    required this.image,
    required this.tech,
    required this.github,
    required this.onGitHubTap,
  });

  @override
  State<_AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<_AnimatedProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        transform:
            _hover ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                _hover
                    ? Colors.green
                    : Colors.green.withOpacity(0.3),
            width: 1.5,
          ),
          color: Colors.black.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color:
                  _hover ? Colors.green.withOpacity(0.3) : Colors.black26,
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background image
            AnimatedOpacity(
              opacity: _hover ? 0.99 : 0.45,
              duration: const Duration(milliseconds: 400),
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                colorBlendMode: BlendMode.darken,
              ),
            ),

            // Foreground content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.desc,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        widget.tech
                            .map(
                              (t) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  border: Border.all(
                                    color: Colors.green.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  t,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: widget.onGitHubTap,
                    icon: const Icon(Icons.link, color: Colors.black, size: 16),
                    label: const Text("View on GitHub"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
