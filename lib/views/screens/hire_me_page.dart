import 'package:flutter/material.dart';
import 'package:s4k1l/views/base/glitch_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HireMePage extends StatelessWidget {
  const HireMePage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    final accent = Colors.green.withOpacity(0.95);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🌟 Hero Section
          Center(
            child: Column(
              children: [
                GlitchText(
                  text: "Let's Build Something Great!",
                  textStyle: TextStyle(
                    fontSize: isMobile ? 34 : 52,
                    fontWeight: FontWeight.bold,
                  ),
                  randomLetterSwitch: true,
                ),
                const SizedBox(height: 8),
                Text(
                  "Turning ideas into scalable, pixel-perfect Flutter apps 🚀",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 14 : 18,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // 💡 Why Hire Me Section
          Text(
            "Why Hire Me?",
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _highlightCard(
                icon: Icons.bolt_rounded,
                title: "Proven Expertise",
                desc:
                    "Over 3 years of professional and personal experience in building modern Flutter apps that are fast, scalable, and elegant.",
                accent: accent,
                width: isMobile ? size.width : size.width * 0.28,
              ),
              _highlightCard(
                icon: Icons.auto_fix_high_rounded,
                title: "Creative Problem Solver",
                desc:
                    "I turn complex challenges into simple, delightful user experiences using clean code and solid architecture.",
                accent: accent,
                width: isMobile ? size.width : size.width * 0.28,
              ),
              _highlightCard(
                icon: Icons.rocket_launch_rounded,
                title: "Focused on Impact",
                desc:
                    "Every project I take is built with performance, scalability, and long-term maintainability in mind.",
                accent: accent,
                width: isMobile ? size.width : size.width * 0.28,
              ),
            ],
          ),
          const SizedBox(height: 60),

          // ✉️ Contact Section
          Center(
            child: Column(
              children: [
                Text(
                  "Let’s Connect",
                  style: TextStyle(
                    fontSize: isMobile ? 26 : 34,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    _contactButton(Icons.email_outlined, "Email Me",
                        () => _launchUrl(
                            "mailto:69shakilmahmud@gmail.com?subject=Hiring Opportunity&body=Hi Shakil, I’d like to discuss a project with you.")),
                    _contactButton(Icons.link, "LinkedIn",
                        () => _launchUrl("https://www.linkedin.com/in/s4k1l/")),
                    _contactButton(Icons.code_rounded, "GitHub",
                        () => _launchUrl("https://github.com/S4K1L")),
                    _contactButton(Icons.facebook, "Facebook",
                        () => _launchUrl("https://www.facebook.com/s4k1ll")),
                    _contactButton(Icons.phone, "Contact",
                        () => _launchUrl("tel:+8801941271076")),
                    _contactButton(Icons.picture_as_pdf_rounded, "View CV",
                        () => _launchUrl(
                            "https://drive.google.com/file/d/1-NjeL20TYeViROxPFXh0GT-HBnFGH18k/view?usp=sharing")),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // 🌙 Footer
          Divider(color: Colors.white24, thickness: 0.4),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Text(
                  "“Clean Code, Creative Design, and Continuous Growth.”",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 14 : 16,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "© 2025 Shakil Mahmud • Crafted with Flutter 💚",
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightCard({
    required IconData icon,
    required String title,
    required String desc,
    required Color accent,
    required double width,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 28),
          const SizedBox(height: 10),
          Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _experienceCard(Map<String, dynamic> exp, Color accent, bool isMobile) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(exp["role"],
              style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: accent)),
          const SizedBox(height: 4),
          Text("${exp["company"]} • ${exp["duration"]}",
              style: const TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 8),
          ...List.generate(
            (exp["tasks"] as List).length,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ",
                      style: TextStyle(color: Colors.white60, fontSize: 13)),
                  Expanded(
                    child: Text(
                      exp["tasks"][i],
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.withOpacity(0.95)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.green.withOpacity(0.95), size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}