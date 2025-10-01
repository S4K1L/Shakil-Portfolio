import 'package:flutter/material.dart';
import '../base/glitch_text.dart';

class ExperiencesPage extends StatelessWidget {
  const ExperiencesPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlitchText(
            text: "Work Experience",
            textStyle: TextStyle(fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.bold),
            randomLetterSwitch: true,
            glitchUpDown: true,
          ),
          const SizedBox(height: 24),

          Column(
            children: workExperience.map((exp) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline indicator
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 120,
                          color: Colors.greenAccent.withOpacity(0.5),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),

                    // Content
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlitchText(
                              text: "${exp['role']!}",
                              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              randomLetterSwitch: true,
                            ),
                            const SizedBox(height: 4),
                            GlitchText(
                              text: "${exp['company']!}",
                              textStyle: const TextStyle(fontSize: 16, color: Colors.white70),
                              randomLetterSwitch: true,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${exp['duration']!}",
                              style: const TextStyle(fontSize: 14, color: Colors.white54),
                            ),
                            const SizedBox(height: 8),
                            ...List<Widget>.from((exp['tasks'] as List<String>).map(
                                  (task) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("• ", style: TextStyle(color: Colors.greenAccent, fontSize: 14)),
                                    Expanded(
                                      child: Text(
                                        task,
                                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
