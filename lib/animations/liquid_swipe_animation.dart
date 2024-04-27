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

// A StatefulWidget that animates a liquid swipe effect on its child widget.
class LiquidSwipeAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // Whether the animation should repeat or not. Defaults to true.
  final bool repeat;

  // Constructor for LiquidSwipeAnimation.
  const LiquidSwipeAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<LiquidSwipeAnimation> createState() => _LiquidSwipeAnimationState();
}

// The state for LiquidSwipeAnimation.
class _LiquidSwipeAnimationState extends State<LiquidSwipeAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the animation.
  late final AnimationController _controller;

  // The animation that drives the liquid swipe effect.
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

    // Creates a tween animation that animates from 0 to 1.
    _animation = Tween<double>(begin: 0, end: 1).animate(
      // Uses a curved animation with an ease-in-out curve.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // If the animation should repeat, sets the controller to repeat.
    if (widget.repeat) {
      _controller.repeat(reverse: true);
    } else {
      // Otherwise, starts the animation forward.
      _controller.forward();
    }
  }

  // Disposes of the animation controller when the state is disposed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the widget tree for this state.
  @override
  Widget build(BuildContext context) {
    // Uses an AnimatedBuilder to rebuild the widget tree when the animation changes.
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Clips the child widget using a custom clipper that animates the liquid swipe effect.
        return ClipPath(
          clipper: _LiquidSwipeClipper(
            // Passes the current animation progress to the clipper.
            progress: _animation.value,
          ),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}

// A custom clipper that animates the liquid swipe effect.
class _LiquidSwipeClipper extends CustomClipper<Path> {
  // The current progress of the animation.
  final double progress;

  // Constructor for _LiquidSwipeClipper.
  _LiquidSwipeClipper({
    required this.progress,
  });

  // Returns the clipping path for the given size.
  @override
  Path getClip(Size size) {
    final path = Path();

    // Moves the path to the starting point of the liquid swipe effect.
    path.moveTo(0, size.height * (1 - progress));

    // Draws a quadratic Bezier curve to create the liquid swipe effect.
    path.quadraticBezierTo(
      size.width / 2,
      size.height * (1 - progress * 2),
      size.width,
      size.height * (1 - progress),
    );

    // Closes the path by drawing a line to the bottom-right corner and then to the bottom-left corner.
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  // Returns whether the clipper should be recalculated when the progress changes.
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Returns true if the old clipper is an instance of _LiquidSwipeClipper and its progress is different.
    return oldClipper is _LiquidSwipeClipper && oldClipper.progress != progress;
  }
}
