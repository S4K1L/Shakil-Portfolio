import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HireMePage extends StatelessWidget {
  const HireMePage({super.key});

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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Hire Me!",
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // // About Section
          // Text(
          //   "👋 Hi, I’m Shakil Mahmud — a passionate Flutter Developer with experience in building high-quality, scalable mobile applications using Flutter, Firebase, and REST APIs. I focus on clean architecture, smooth UI/UX, and performance optimization. If you’re looking for someone who can bring your app ideas to life — let’s connect!",
          //   style: const TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
          // ),
          // const SizedBox(height: 32),

          // Contact Buttons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _contactButton(
                icon: Icons.email_outlined,
                label: "Email Me",
                onTap: () => _launchUrl(
                  "mailto:69shakilmahmud@gmail.com?subject=Hiring Opportunity&body=Hi Shakil, I’d like to discuss a project with you.",
                ),
              ),
              _contactButton(
                icon: Icons.linked_camera_outlined,
                label: "LinkedIn",
                onTap: () => _launchUrl("https://www.linkedin.com/in/s4k1l/"),
              ),
              _contactButton(
                icon: Icons.facebook_outlined,
                label: "Facebook",
                onTap: () => _launchUrl("https://www.facebook.com/s4k1ll"),
              ),
              _contactButton(
                icon: Icons.picture_as_pdf_outlined,
                label: "GitHub",
                onTap: () => _launchUrl("https://github.com/S4K1L"),
              ),
              _contactButton(
                icon: Icons.call_outlined,
                label: "Contact",
                onTap: () => _launchUrl("tel:+8801941271076"),
              ),
              _contactButton(
                icon: Icons.picture_as_pdf_outlined,
                label: "View My CV",
                onTap: () => _launchUrl(
                  "https://drive.google.com/file/d/12JfSwcRJy2pQj8re7SjkQqUft7i4eUB4/view?usp=sharing",
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Work Experience
          Text(
            "Work Experience",
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 16),

          // Experience Timeline
          Column(
            children: workExperience.map((Map<String, dynamic> exp) {
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
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 120,
                          color: Colors.green.withOpacity(0.5),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),

                    // Content
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          border:
                              Border.all(color: Colors.greenAccent, width: 1),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp['role']!,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.withOpacity(0.95)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exp['company']!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exp['duration']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...List<Widget>.from(
                              (exp['tasks'] as List<String>).map(
                                (task) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "• ",
                                        style: TextStyle(
                                          color: Colors.green.withOpacity(
                                            .95,
                                          ),
                                          fontSize: 14,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          task,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 60),

          // Footer
          Center(
            child: Text(
              "Let’s build something amazing together 💻🚀",
              style: TextStyle(
                color: Colors.green.withOpacity(.95),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "© 2025 Shakil Mahmud",
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.withOpacity(.95)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.green.withOpacity(.95), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
