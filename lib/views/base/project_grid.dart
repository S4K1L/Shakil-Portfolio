import 'package:flutter/material.dart';

class ProjectsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> projects;
  final bool isMobile;
  final void Function(String url) onGitHubTap;

  const ProjectsGrid({
    super.key,
    required this.projects,
    required this.isMobile,
    required this.onGitHubTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: projects.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 1 : 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: isMobile ? 1.1 : 1.4,
        ),
        itemBuilder: (context, index) {
          final proj = projects[index];
          return _AnimatedProjectCard(
            name: proj["name"] as String,
            desc: proj["desc"] as String,
            image: proj["image"] as String,
            tech: List<String>.from(proj["tech"] as List),
            github: proj["github"] as String,
            onGitHubTap: () => onGitHubTap(proj["github"] as String),
          );
        },
      ),
    );
  }
}

class _AnimatedProjectCard extends StatefulWidget {
  final String name;
  final String desc;
  final String image;
  final List<String> tech;
  final String github;
  final VoidCallback onGitHubTap;

  const _AnimatedProjectCard({
    required this.name,
    required this.desc,
    required this.image,
    required this.tech,
    required this.github,
    required this.onGitHubTap,
  });

  @override
  State<_AnimatedProjectCard> createState() => _AnimatedProjectCardState();
}

class _AnimatedProjectCardState extends State<_AnimatedProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        transform:
            _hover ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hover ? Colors.green : Colors.green.withOpacity(0.3),
            width: 1.5,
          ),
          color: Colors.black.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color: _hover ? Colors.green.withOpacity(0.3) : Colors.black26,
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background image
            AnimatedOpacity(
              opacity: _hover ? 0.99 : 0.25,
              duration: const Duration(milliseconds: 400),
              child: Image.asset(
                widget.image,
                // fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                colorBlendMode: BlendMode.darken,
              ),
            ),

            // Foreground content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.desc,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: widget.tech
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: widget.onGitHubTap,
                    icon: const Icon(Icons.link, color: Colors.black, size: 16),
                    label: const Text("View on GitHub"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
