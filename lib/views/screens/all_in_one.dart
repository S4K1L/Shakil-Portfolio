import 'package:flutter/material.dart';
import 'package:s4k1l/views/screens/about_me_page.dart';
import 'package:s4k1l/views/screens/projects_page.dart';
import 'package:s4k1l/views/screens/hire_me_page.dart';
import '../base/glitch_text.dart';
import '../base/glitch_image.dart';

class PortfolioLandingPage extends StatelessWidget {
  const PortfolioLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🏠 Hero Section
            Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildHeroSection(isMobile),
            ),

            // 👨‍💻 About Me
            const AboutMePage(),

            // 🧠 Projects Section
            const ProjectsPage(),

            // 🤝 Hire Me Section
            const HireMePage(),

            // 🦶 Footer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "© 2025 Shakil Mahmud | Built with Flutter 💙",
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlitchText(
          text: "SHAKIL MAHMUD",
          textStyle: TextStyle(
            fontSize: isMobile ? 36 : 72,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GlitchText(
          text: "Flutter Developer | Problem Solver | App Architect",
          textStyle: TextStyle(
            fontSize: isMobile ? 18 : 28,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 24),
        const GlitchImage(
          imageProvider: AssetImage("assets/images/profile.png"),
          maxWidth: 250,
          maxHeight: 250,
        ),
      ],
    );
  }
}
