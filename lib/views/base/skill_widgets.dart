import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<String> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate number of columns dynamically
    int crossAxisCount = 3;
    if (screenWidth > 1400) {
      crossAxisCount = 6;
    } else if (screenWidth > 1000) {
      crossAxisCount = 6;
    } else if (screenWidth > 700) {
      crossAxisCount = 4;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 4,
      ),
      itemBuilder: (context, index) {
        return _SkillCard(skill: skills[index]);
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final String skill;
  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.greenAccent.shade400;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _hover
                ? [themeColor.withOpacity(0.3), Colors.black.withOpacity(0.8)]
                : [Colors.black.withOpacity(0.8), Colors.grey.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _hover ? themeColor : themeColor.withOpacity(0.4),
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: _hover
                  ? themeColor.withOpacity(0.5)
                  : Colors.greenAccent.withOpacity(0.2),
              blurRadius: _hover ? 20 : 8,
              spreadRadius: _hover ? 2 : 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              widget.skill.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _hover ? themeColor : Colors.white70,
                fontWeight: FontWeight.w400,
                // fontSize: 15,
                letterSpacing: .5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
