import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<Map<String, String>> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (width > 1400) {
      crossAxisCount = 10;
    } else if (width > 1000) {
      crossAxisCount = 8;
    } else if (width > 600) {
      crossAxisCount = 6;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, index) {
        return SkillCard(
          title: skills[index]["name"]!,
          iconPath: skills[index]["icon"]!,
        );
      },
    );
  }
}

class SkillCard extends StatefulWidget {
  final String title;
  final String iconPath;

  const SkillCard({super.key, required this.title, required this.iconPath});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // --- RESPONSIVE VALUES ---
    final bool isMobile = width < 450;
    final bool isTablet = width > 450 && width < 1100;

    final double iconSize = isMobile
        ? 40
        : isTablet
            ? 80
            : 90;
    final double padding = isMobile ? 8 : 14;

    // Disable hover on touch devices
    final bool allowHover = !isMobile;

    return MouseRegion(
      onEnter: (_) {
        if (allowHover) setState(() => _hover = true);
      },
      onExit: (_) {
        if (allowHover) setState(() => _hover = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hover ? Colors.greenAccent : Colors.white12,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hover
                  ? Colors.greenAccent.withValues(alpha: .35)
                  : Colors.black54,
              blurRadius: _hover ? 25 : 8,
              spreadRadius: _hover ? 2 : 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: SizedBox(
            height: iconSize,
            child: Image.asset(widget.iconPath, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
