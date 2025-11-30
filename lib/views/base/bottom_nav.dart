import 'package:flutter/material.dart';
import 'glitch_text.dart';

class BottomNav extends StatelessWidget {
  final int activeIndex;
  final Function(int) onItemTap;

  const BottomNav({
    super.key,
    required this.activeIndex,
    required this.onItemTap,
  });

  final items = const ["Home", "Projects", "About Me", "Hire Me"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // slightly taller to fit the Lottie
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
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
                // // ✅ Lottie animation only when active
                // if (isActive)
                //   SizedBox(
                //     height: 30,
                //     width: 30,
                //     child: Lottie.asset(
                //       lottiePath,
                //       repeat: true,
                //       animate: true,
                //     ),
                //   )
                // else
                //   const SizedBox(height: 30),

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
                  duration: const Duration(milliseconds: 1000),
                  height: 3,
                  width: isActive ? 30 : 0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.greenAccent, Colors.green],
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
