import 'dart:math';
import 'package:flutter/material.dart';

class GlitchImage extends StatefulWidget {
  final ImageProvider imageProvider;
  final double maxWidth;
  final double maxHeight;

  const GlitchImage({
    super.key,
    required this.imageProvider,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  State<GlitchImage> createState() => _GlitchImageState();
}

class _GlitchImageState extends State<GlitchImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final Random _r = Random();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Offset _randOffset(double range) => Offset(
        (_r.nextDouble() - 0.5) * range,
        (_r.nextDouble() - 0.5) * range,
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = min(widget.maxWidth, constraints.maxWidth);
        final height = min(widget.maxHeight, constraints.maxHeight);

        return SizedBox(
          width: width,
          height: height,
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (context, child) {
              final phase = sin(_ctrl.value * 2 * pi);
              final shift = 8.0 * phase;
              final offsetRed = _randOffset(shift);
              final offsetGreen = _randOffset(shift * 0.6);

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Red channel
                  Transform.translate(
                    offset: offsetRed,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.matrix([
                        1,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                      ]),
                      child: Image(
                        image: widget.imageProvider,
                        fit: BoxFit.contain,
                        width: width,
                        height: height,
                      ),
                    ),
                  ),

                  // Green channel
                  Transform.translate(
                    offset: offsetGreen,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.matrix([
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        0,
                        1,
                        0,
                      ]),
                      child: Image(
                        image: widget.imageProvider,
                        fit: BoxFit.contain,
                        width: width,
                        height: height,
                      ),
                    ),
                  ),

                  // Blue channel normal
                  Image(
                    image: widget.imageProvider,
                    fit: BoxFit.contain,
                    width: width,
                    height: height,
                    color: Colors.white.withOpacity(0.02),
                    colorBlendMode: BlendMode.modulate,
                  ),

                  // Horizontal flicker slice
                  // Positioned(
                  //   top: height * 0.2 + (6 * phase),
                  //   left: 0,
                  //   right: 0,
                  //   height: max(4.0, 6.0 * phase.abs()),
                  //   child: BackdropFilter(
                  //     filter: ui.ImageFilter.blur(
                  //       sigmaX: 1.5 * phase.abs(),
                  //       sigmaY: 1.2 * phase.abs(),
                  //     ),
                  //     child: Container(
                  //       color: Colors.white.withOpacity(0.02 * phase.abs()),
                  //     ),
                  //   ),
                  // ),

                  // Border and glow
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00FFD5)
                              .withOpacity(0.08 + 0.03 * phase.abs()),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
