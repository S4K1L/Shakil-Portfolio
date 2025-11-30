import 'package:flutter/material.dart';

class AchievementsSection extends StatelessWidget {
  final List<String> achievements;
  const AchievementsSection({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: achievements
          .map(
            (ach) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "• ",
                  style: TextStyle(color: Colors.greenAccent),
                ),
                Expanded(
                  child: Text(
                    ach,
                    style:
                        TextStyle(color: Colors.green.withValues(alpha: 0.95)),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
