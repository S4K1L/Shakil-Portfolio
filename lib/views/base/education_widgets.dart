import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  final List<Map<String, String>> education;
  const EducationSection({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
              color: Colors.green.withValues(alpha: 0.5),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: education.map((edu) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  border: Border.all(color: Colors.greenAccent, width: 1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu['degree']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.withValues(alpha: 0.95),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu['institute']!,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu['grad']!,
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
