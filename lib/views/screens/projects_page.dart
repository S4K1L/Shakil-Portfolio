import 'package:flutter/material.dart';
import 'package:s4k1l/data/personal_data.dart';
import 'package:s4k1l/views/base/project_grid.dart';
import 'package:url_launcher/url_launcher.dart';
import '../base/glitch_text.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    for (var project in PersonalData().projects) {
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
                  projects: PersonalData().projects,
                  isMobile: MediaQuery.of(context).size.width < 600,
                  onGitHubTap: (url) => _launchUrl(url),
                ),
              ],
            ),
    );
  }
}
