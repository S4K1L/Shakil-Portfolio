import 'package:flutter/material.dart';
import 'package:s4k1l/data/personal_data.dart';
import 'package:s4k1l/views/base/achievement_widgets.dart';
import 'package:s4k1l/views/base/education_widgets.dart';
import 'package:s4k1l/views/base/experience_section.dart';
import 'package:s4k1l/views/base/skill_widgets.dart';
import '../base/glitch_text.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          // Header
          GlitchText(
            text: "About Me",
            textStyle: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
            ),
            randomLetterSwitch: true,
            glitchUpDown: true,
          ),
          const SizedBox(height: 20),

          // Brief intro
          GlitchText(
            text: PersonalData().intro,
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
            randomLetterSwitch: false,
          ),
          const SizedBox(height: 30),
          GlitchText(
            text: "Skills",
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 12),
          // Skills
          SkillsSection(skills: PersonalData().skills),
          const SizedBox(height: 30),
          // Achievements
          GlitchText(
            text: "Achievements",
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 12),
          AchievementsSection(achievements: PersonalData().achievements),
          const SizedBox(height: 30),

          // Education
          GlitchText(
            text: "Education",
            textStyle: TextStyle(
                fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.bold),
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 12),
          EducationSection(education: PersonalData().education),
          const SizedBox(height: 30),

          // Work Experience
          GlitchText(
            text: "Work Experience",
            textStyle: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 16),
          WorkExperienceSection(workExperience: PersonalData().workExperience),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
