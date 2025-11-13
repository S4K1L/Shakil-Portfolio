import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSlimyCard extends StatefulWidget {
  final String name;
  final String desc;
  final String image;
  final List<String> tech;
  final List<String> features;
  final VoidCallback onGitHubTap;
  final VoidCallback? onStoreTap;

  const CustomSlimyCard({
    super.key,
    required this.name,
    required this.desc,
    required this.image,
    required this.tech,
    required this.features,
    required this.onGitHubTap,
    this.onStoreTap,
  });

  @override
  State<CustomSlimyCard> createState() => _CustomSlimyCardState();
}

class _CustomSlimyCardState extends State<CustomSlimyCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggleCard() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.greenAccent.shade400;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final height = 280 + (160 * _animation.value);
        return Center(
          child: Container(
            width: 500,
            height: height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: themeColor.withOpacity(0.4),
                  blurRadius: 25,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image background
                Positioned.fill(
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.6),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),

                // Card content
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(widget.image),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.name,
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.desc,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      // Down arrow
                      GestureDetector(
                        onTap: _toggleCard,
                        child: AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 28,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Animated Bottom Section
                    ClipRect(
  child: Align(
    heightFactor: _animation.value,
    child: Opacity(
      opacity: _animation.value,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Core Features:",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              ...widget.features.take(3).map(
                    (f) => Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 14),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            f,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: widget.onGitHubTap,
                icon:  Icon(Icons.code, color: Colors.black, size: 16),
                label: const Text("GitHub"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (widget.onStoreTap != null)
                ElevatedButton.icon(
                  onPressed: widget.onStoreTap,
                  icon: const Icon(Icons.public, color: Colors.black, size: 16),
                  label: const Text("App Store"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
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
      },
    );
  }
}
