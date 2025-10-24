import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BugFollowAnimation extends StatefulWidget {
  final Size size;
  final double mouseX;
  final double mouseY;
  final bool isMouseConnected;
  final String lottieAsset;

  const BugFollowAnimation({
    super.key,
    required this.size,
    this.mouseX = 0,
    this.mouseY = 0,
    this.isMouseConnected = false,
    required this.lottieAsset,
  });

  @override
  State<BugFollowAnimation> createState() => _BugFollowAnimationState();
}

class _BugFollowAnimationState extends State<BugFollowAnimation>
    with SingleTickerProviderStateMixin {
  late double x;
  late double y;
  late double dx;
  late double dy;
  late bool facingRight; // true if moving right
  late AnimationController controller;
  final double speed = 5.0; // maximum speed

  @override
  void initState() {
    super.initState();
    x = widget.size.width / 2;
    y = widget.size.height / 2;
    dx = 0;
    dy = 0;
    facingRight = true;

    controller = AnimationController(
      vsync: this,
      duration: const Duration(hours: 1),
    )..addListener(_updatePosition);

    controller.forward();
  }

  void _updatePosition() {
    if (!widget.isMouseConnected) return;

    double targetX = widget.mouseX;
    double targetY = widget.mouseY;

    double ax = targetX - x;
    double ay = targetY - y;

    // Smooth movement
    dx = ax * 0.05;
    dy = ay * 0.05;

    dx = dx.clamp(-speed, speed);
    dy = dy.clamp(-speed, speed);

    x += dx;
    y += dy;

    // Flip horizontally depending on movement direction
    facingRight = dx >= 0;

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x - 80,
      top: y - 80,
      child: IgnorePointer(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(facingRight ? -1.0 : 1.0, 1.0), // flip horizontally
          child: SizedBox(
            width: 120,
            height: 120,
            child: Lottie.asset(
              widget.lottieAsset,
              repeat: true,
              animate: true,
            ),
          ),
        ),
      ),
    );
  }
}
