import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final bool randomLetterSwitch;
  final bool glitchUpDown;
  final double glitchChance;
  final Duration glitchSpeed;
  final int glitchIntensity;

  const GlitchText({
    super.key,
    required this.text,
    this.textStyle,
    this.randomLetterSwitch = false,
    this.glitchUpDown = false,
    this.glitchChance = 0.35,
    this.glitchSpeed = const Duration(milliseconds: 350),
    this.glitchIntensity = 2,
  });

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final Random _r = Random();
  Timer? _glitchTimer;
  String _currentText = "";

  @override
  void initState() {
    super.initState();
    _currentText = widget.text;

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    if (widget.randomLetterSwitch) {
      _glitchTimer = Timer.periodic(widget.glitchSpeed, (timer) {
        if (_r.nextDouble() < widget.glitchChance) {
          setState(() {
            _currentText = _makeGlitchedText(widget.text);
          });

          Future.delayed(const Duration(milliseconds: 120), () {
            if (mounted) _currentText = widget.text;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _glitchTimer?.cancel();
    super.dispose();
  }

  Offset _randOffset(double range) =>
      Offset((_r.nextDouble() - .5) * range, (_r.nextDouble() - .5) * range);

  String _makeGlitchedText(String text) {
    const glitchChars = ['#', '@', '%', '!', '⍯', '░', '█', '∆'];
    final chars = text.split('');
    final count = min(widget.glitchIntensity, chars.length);
    final indices = <int>{};
    while (indices.length < count) indices.add(_r.nextInt(chars.length));
    for (var i in indices) chars[i] = glitchChars[_r.nextInt(glitchChars.length)];
    return chars.join();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.textStyle?.copyWith(color: Colors.green.withValues(alpha: .95)) ??
        const TextStyle(fontSize: 36, color: Colors.white);

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final t = _ctrl.value;
        final phase = (math.sin(t * 2 * math.pi) + 1) / 2;
        final dx = 2.0 + phase * 6.0;
        final small = _randOffset(dx * 0.3);
        final flip = widget.glitchUpDown && _r.nextDouble() < 0.02;

        Widget ghostLayer(Color c, double offsetX, double offsetY, double blur) {
          return Transform.translate(
            offset: Offset(offsetX, offsetY),
            child: Text(
              _currentText,
              style: baseStyle.copyWith(
                color: c,
                shadows: [Shadow(blurRadius: blur, color: c.withOpacity(0.6))],
              ),
            ),
          );
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            // Red ghost layer
            // ghostLayer(const Color(0xFFFF2D55), -dx, dx, 6),

            // Green ghost layer
            // ghostLayer(const Color(0xFF7CFC00), dx * 0.5, -dx * 0.5, 6),

            // Main text (with slight slice offset for glitch effect)
            Transform.translate(
              offset: small,
              child: Text(
                _currentText,
                style: baseStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}



/// Terminal-like card with flicker and mock content
class TerminalCard extends StatefulWidget {
  const TerminalCard({super.key});
  @override
  State<TerminalCard> createState() => _TerminalCardState();
}

class _TerminalCardState extends State<TerminalCard> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final List<String> _lines = [
    'user@portfolio:~\$ git clone https://git.example/shakil/portfolio',
    'Cloning into \'portfolio\'...',
    'Checking Flutter and Firebase configs',
    'Building app (release)... Done',
    'Deploying to web / github pages: OK',
    'Open: https://shakil.dev',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_ctrl.value * _lines.length).floor();
    final visible = _lines.take(progress.clamp(0, _lines.length)).toList();

    return Container(
      padding: const EdgeInsets.all(14),
      constraints: const BoxConstraints(minHeight: 220),
      decoration: BoxDecoration(
        color: const Color(0xFF041018).withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
        boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.03), blurRadius: 30)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header bar
          Row(
            children: [
              _dot(Colors.red),
              const SizedBox(width: 6),
              _dot(Colors.amber),
              const SizedBox(width: 6),
              _dot(Colors.green),
              const SizedBox(width: 12),
              const Text('project-terminal', style: TextStyle(fontFamily: 'monospace', color: Color(0xFF7DD3FC))),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  children: [
                    for (final l in visible)
                      TextSpan(text: '$l\n', style: const TextStyle(fontFamily: 'monospace', fontSize: 13, color: Color(0xFF9BE7FF))),
                    // blinking caret
                    TextSpan(text: (_ctrl.value * 2 % 1 > 0.5) ? '█' : ' ', style: const TextStyle(fontFamily: 'monospace', color: Color(0xFF7FFFD4))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle));
}

/// Subtle scanlines overlay using a repeating linear gradient
class ScanlinesOverlay extends StatelessWidget {
  const ScanlinesOverlay({super.key});
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: Colors.transparent,
        child: CustomPaint(
          painter: _ScanlinePainter(),
        ),
      ),
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final lineHeight = 2.0;
    final gap = 8.0;
    for (double y = 0; y < size.height; y += lineHeight + gap) {
      paint.color = Colors.black.withOpacity(0.03);
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, lineHeight), paint);
    }
    // vignette
    final rect = Offset.zero & size;
    final gradient = ui.Gradient.radial(
      size.center(Offset.zero),
      max(size.width, size.height),
      [Colors.transparent, Colors.black.withOpacity(0.35)],
      [0.6, 1.0],
    );
    paint.shader = gradient;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}