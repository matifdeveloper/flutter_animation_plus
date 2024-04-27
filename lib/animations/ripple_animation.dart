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

// A StatefulWidget that creates a ripple animation effect around its child widget.
class RippleAnimation extends StatefulWidget {
  // The child widget to be wrapped with the ripple animation.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag to indicate whether the animation should repeat or not.
  final bool repeat;

  // Constructor for RippleAnimation.
  const RippleAnimation({
    super.key,
    required this.child,
    required this.duration,
    // By default, the animation will repeat.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

// The state class for RippleAnimation.
class _RippleAnimationState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the ripple animation.
  late final AnimationController _controller;

  // The animation that drives the ripple effect.
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

    // Creates a tween animation that goes from 0 to 1.
    _animation = Tween<double>(begin: 0, end: 1).animate(
      // Uses a curved animation to make the animation more natural.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // If the animation should repeat, starts the animation in a loop.
    if (widget.repeat) {
      _controller.repeat();
    } else {
      // Otherwise, starts the animation once.
      _controller.forward();
    }
  }

  // Disposes of the animation controller when the widget is removed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the widget tree.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // Listens to the animation and rebuilds the widget tree when it changes.
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            // Creates a positioned widget that fills the available space.
            Positioned.fill(
              child: CustomPaint(
                // Creates a custom painter that draws the ripple effect.
                painter: _RipplePainter(
                  // Passes the current animation progress to the painter.
                  progress: _animation.value,
                  color: Colors.blue,
                ),
              ),
            ),
            // The original child widget.
            widget.child,
          ],
        );
      },
      child: widget.child,
    );
  }
}

// A custom painter that draws a circle with a radius based on the animation progress.
class _RipplePainter extends CustomPainter {
  // The current animation progress.
  final double progress;

  // The color of the ripple effect.
  final Color color;

  // Constructor for _RipplePainter.
  _RipplePainter({
    required this.progress,
    required this.color,
  });

  // Paints the ripple effect on the canvas.
  @override
  void paint(Canvas canvas, Size size) {
    // Calculates the center of the canvas.
    final center = Offset(size.width / 2, size.height / 2);

    // Calculates the radius of the circle based on the animation progress.
    final radius = size.width * progress;

    // Creates a paint object with the specified color and stroke width.
    final paint = Paint()
      ..color = color.withOpacity(1 - progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draws a circle on the canvas.
    canvas.drawCircle(center, radius, paint);
  }

  // Always returns true to ensure the painter is rebuilt on every frame.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
