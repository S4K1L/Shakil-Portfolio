import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback? onIconTap;
  const TopBar({super.key, this.onIconTap});

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
          const Text(
            "SHAKIL MAHMUD",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
          const Spacer(),

          // 🪄 Tap this to open animation selector
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/bd.png"),
          ),
        ],
      ),
    );
  }
}
