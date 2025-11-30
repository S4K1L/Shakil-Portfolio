import 'package:flutter/material.dart';
import 'package:s4k1l/views/base/custom_slim_card.dart';

class ProjectsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> projects;
  final bool isMobile;
  final void Function(String url) onGitHubTap;
  final void Function(String url)? onStoreTap;

  const ProjectsGrid({
    super.key,
    required this.projects,
    required this.isMobile,
    required this.onGitHubTap,
    this.onStoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;
    if (screenWidth > 1500) {
      crossAxisCount = 4;
    } else if (screenWidth > 1000) {
      crossAxisCount = 3;
    } else if (screenWidth > 700) {
      crossAxisCount = 2;
    }

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: projects.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: isMobile ? 0.75 : 1.0,
        ),
        itemBuilder: (context, index) {
          final proj = projects[index];
          return CustomSlimyCard(
            name: proj["name"],
            desc: proj["desc"],
            image: proj["image"],
            tech: List<String>.from(proj["tech"] ?? []),
            features: List<String>.from(proj["features"] ?? []),
            onGitHubTap: () => onGitHubTap(proj["github"]),
            onStoreTap: proj["store"] != null
                ? () => onStoreTap?.call(proj["store"])
                : null,
          );
        },
      ),
    );
  }
}
