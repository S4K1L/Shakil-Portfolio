import 'dart:math';
import 'dart:math' as math;
import 'dart:async';
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
      Offset((_r.nextDouble() - .9) * range, (_r.nextDouble() - .9) * range);

  String _makeGlitchedText(String text) {
    const glitchChars = ['#', '@', '%', '!', '⍯', '░', '█', '∆'];
    final chars = text.split('');
    final count = min(widget.glitchIntensity, chars.length);
    final indices = <int>{};
    while (indices.length < count) {
      indices.add(_r.nextInt(chars.length));
    }
    for (var i in indices) {
      chars[i] = glitchChars[_r.nextInt(glitchChars.length)];
    }
    return chars.join();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.textStyle
            ?.copyWith(color: Colors.green.withValues(alpha: 0.95)) ??
        const TextStyle(fontSize: 36, color: Colors.white);

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final t = _ctrl.value;
        final phase = (math.sin(t * 2 * math.pi) + 1) / 2;
        final dx = 2.0 + phase * 6.0;
        final small = _randOffset(dx * 0.3);

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: small,
              child: Text(
                _currentText,
                style: baseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
