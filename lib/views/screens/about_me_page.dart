import 'package:flutter/material.dart';
import 'package:s4k1l/views/base/achievement_widgets.dart';
import 'package:s4k1l/views/base/education_widgets.dart';
import 'package:s4k1l/views/base/experience_section.dart';
import 'package:s4k1l/views/base/skill_widgets.dart';
import '../base/glitch_text.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  final skills = const [
    "Dart",
    "Flutter",
    "OOP",
    "REST API",
    "Database (MySQL)",
    "C / C++",
    "Problem Solving",
    "Responsive Design",
    "Version Control (Git)",
    "Github",
    "Team Collaboration",
    "Figma",
    "IoT",
    "GetX State Management",
    "Firebase",
    "Supabase",
  ];

  final education = const [
    {
      "degree": "BSc in CSE",
      "institute": "Shanto-Mariam University of Creative Technology",
      "grad": "Expected Graduation: Nov 2026",
    },
  ];

  final workExperience = const [
    {
      "role": "Mid-Level Flutter Developer (Onsite)",
      "company": "Join Venture AI (Betopia Group)",
      "duration": "08/2025 - Present",
      "tasks": [
        "Developed and maintained cross-platform mobile apps with Flutter & Dart.",
        "Integrated REST APIs, Firebase services, and third-party SDKs.",
        "Collaborated with designers and backend engineers to deliver high-quality features.",
      ],
    },
    {
      "role": "Mobile App Developer (Remote)",
      "company": "mADestic Digital",
      "duration": "04/2025 - 08/2025",
      "tasks": [
        "Architected and launched a high-performance mobile app, achieving near-perfect store rating.",
        "Implemented advanced caching and code optimization strategies.",
        "Leveraged native device APIs and external services for cross-platform features.",
        "Refined UI components based on user-centric design principles.",
        "Integrated multiple RESTful APIs and third-party services.",
      ],
    },
    {
      "role": "Software Developer (Remote)",
      "company": "Globalite Solutions, Malaysia",
      "duration": "03/2024 - 04/2025",
      "tasks": [
        "Engineered and maintained robust Flutter apps, boosting user retention.",
        "Projects: Expense Tracker, Mental Health Care Bot (GPT4o), Ecommerce App.",
        "GetX state management & secure authentication integration.",
      ],
    },
  ];

  final achievements = const [
    "Intra Dept Programming Competition - SMUCT - Champion",
    "North Western Programming Competition, Khulna - 7th",
    "ICPC Online Preliminary (2023-2024) - 1184 & 880",
    "Intra Dept Robo Soccer - SMUCT - Champion",
    "Intra Dept Project Showcase - SMUCT - Champion",
    "DUET Project Showcase 2023 - DUET (5th)",
  ];

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
            text:
                "Hi, I'm Shakil Mahmud, a Flutter developer with a proven track record in building high-performance mobile applications, including task management, eCommerce solutions. Proficient in REST API integration and state management using GetX, with a strong commitment to delivering efficient, scalable, and user-friendly applications.",
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
            randomLetterSwitch: false,
          ),
          const SizedBox(height: 30),
          // Achievements
          GlitchText(
            text: "Achievements",
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 12),
          AchievementsSection(achievements: achievements),
          const SizedBox(height: 30),

           // Education
          GlitchText(
            text: "Education",
            textStyle:
                TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.bold),
            randomLetterSwitch: true,
          ),
          const SizedBox(height: 12),
          EducationSection(education: education),
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
          WorkExperienceSection(workExperience: workExperience),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
