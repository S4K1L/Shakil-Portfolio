import 'package:flutter/material.dart';
import 'glitch_text.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.redAccent.withOpacity(0.9),
      Colors.amberAccent.withOpacity(0.9),
      Colors.greenAccent.withOpacity(0.9),
    ];

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          // iOS style traffic-light dots
          Row(
            children: List.generate(
              3,
                  (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: colors[i],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Glitch rotating words
          const GlitchText(
            text: "SHAKIL MAHMUD",
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),

          // Right-side icon
          const Icon(Icons.highlight_remove, color: Colors.green),
        ],
      ),
    );
  }
}
