/*
********************************************************************************

    _____/\\\\\\\\\_____/\\\\\\\\\\\\\\\__/\\\\\\\\\\\__/\\\\\\\\\\\\\\\_
    ___/\\\\\\\\\\\\\__\///////\\\/////__\/////\\\///__\/\\\///////////__
    __/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\\\\\\\\\_____
    _\/\\\\\\\\\\\\\\\_______\/\\\___________\/\\\_____\/\\\///////______
    _\/\\\/////////\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\___________\/\\\_____\/\\\_____________
    _\/\\\_______\/\\\_______\/\\\________/\\\\\\\\\\\_\/\\\_____________
    _\///________\///________\///________\///////////__\///______________

    Created by Muhammad Atif on 4/27/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'package:flutter/material.dart';
import 'dart:math' as math;

// A StatefulWidget that creates a kaleidoscope animation.
class KaleidoscopeAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // Whether the animation should repeat.
  final bool repeat;

  // Constructor for KaleidoscopeAnimation.
  const KaleidoscopeAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = true, // Default value for repeat is true.
  });

  // Creates the state for this widget.
  @override
  State<KaleidoscopeAnimation> createState() => _KaleidoscopeAnimationState();
}

// The state for KaleidoscopeAnimation.
class _KaleidoscopeAnimationState extends State<KaleidoscopeAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the animation.
  late final AnimationController _controller;

  // The animation that drives the kaleidoscope effect.
  late final Animation<double> _animation;

  // Initializes the state.
  @override
  void initState() {
    super.initState();

    // Creates an animation controller with the specified duration.
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Creates a tween animation that goes from 0 to 2 * pi.
    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      // Uses a curved animation with an ease-in-out curve.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // If repeat is true, repeats the animation indefinitely.
    if (widget.repeat) {
      _controller.repeat();
    } else {
      // Otherwise, plays the animation once.
      _controller.forward();
    }
  }

  // Disposes of the animation controller when the widget is disposed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the widget tree.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // Listens to the animation.
      animation: _animation,
      builder: (context, child) {
        return Transform(
          // Centers the transformation.
          alignment: Alignment.center,
          // Creates a 3D transformation matrix.
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateZ(_animation.value),
          child: CustomPaint(
            // Creates a custom painter for the kaleidoscope effect.
            painter: _KaleidoscopePainter(
              // Passes the animation progress to the painter.
              progress: _animation.value,
            ),
            child: widget.child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

// A custom painter for the kaleidoscope effect.
class _KaleidoscopePainter extends CustomPainter {
  // The progress of the animation.
  final double progress;

  // Constructor for _KaleidoscopePainter.
  _KaleidoscopePainter({
    required this.progress,
  });

  // Paints the kaleidoscope effect.
  @override
  void paint(Canvas canvas, Size size) {
    // Calculates the center of the canvas.
    final center = Offset(size.width / 2, size.height / 2);

    // Saves the current canvas state.
    canvas.save();
    // Translates the canvas to the center.
    canvas.translate(center.dx, center.dy);
    // Rotates the canvas by the animation progress.
    canvas.rotate(progress);
    // Translates the canvas back to the origin.
    canvas.translate(-center.dx, -center.dy);

    // Draws 6 rectangles with different colors, rotated by 60 degrees each.
    for (int i = 0; i < 6; i++) {
      canvas.save();
      canvas.rotate(i * (2 * math.pi / 6));
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.primaries[i % Colors.primaries.length],
      );
      canvas.restore();
    }

    // Restores the original canvas state.
    canvas.restore();
  }

  // Always repaints the canvas when the animation progresses.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
