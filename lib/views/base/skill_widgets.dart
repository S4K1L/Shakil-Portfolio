import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<String> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: skills
          .map(
            (skill) => Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.1),
                border: Border.all(color: Colors.greenAccent, width: 1),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                skill,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          )
          .toList(),
    );
  }
}
