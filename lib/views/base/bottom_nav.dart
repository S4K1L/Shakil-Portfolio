import 'package:flutter/material.dart';
import 'glitch_text.dart';

class BottomNav extends StatelessWidget {
  final int activeIndex;
  final Function(int) onItemTap;
  const BottomNav({super.key, required this.activeIndex, required this.onItemTap});

  final items = const ["Home", "Experiences", "Projects", "About Me"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final isActive = activeIndex == index;

          return GestureDetector(
            onTap: () => onItemTap(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlitchText(
                  text: items[index],
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.greenAccent : Colors.white70,
                  ),
                  randomLetterSwitch: true,
                  glitchUpDown: true,
                  glitchChance: isActive ? 0.7 : 0.35,
                  glitchSpeed: Duration(milliseconds: isActive ? 250 : 400),
                  glitchIntensity: isActive ? 2 : 1,
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 3,
                  width: isActive ? 30 : 0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.greenAccent, Colors.tealAccent],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
