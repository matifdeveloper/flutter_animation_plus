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

// A StatefulWidget that animates a blob-like shape around its child widget.
class BlobAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // Whether the animation should repeat or not. Defaults to true.
  final bool repeat;

  // Constructor for BlobAnimation.
  const BlobAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<BlobAnimation> createState() => _BlobAnimationState();
}

// The state for the BlobAnimation widget.
class _BlobAnimationState extends State<BlobAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the animation.
  late final AnimationController _controller;

  // The animation that drives the blob shape.
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

  // Disposes of the animation controller when the widget is disposed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the widget tree.
  @override
  Widget build(BuildContext context) {
    // Uses an AnimatedBuilder to rebuild the widget tree when the animation changes.
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Clips the child widget with a blob-like shape.
        return ClipPath(
          // Uses a custom clipper to define the blob shape.
          clipper: _BlobClipper(
            // The progress of the animation, which drives the shape of the blob.
            progress: _animation.value,
          ),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}

// A custom clipper that defines a blob-like shape.
class _BlobClipper extends CustomClipper<Path> {
  // The progress of the animation, which drives the shape of the blob.
  final double progress;

  // Constructor for _BlobClipper.
  _BlobClipper({
    required this.progress,
  });

  // Returns the path for the blob shape.
  @override
  Path getClip(Size size) {
    final path = Path();

    // Moves to the starting point of the path.
    path.moveTo(0, size.height * (1 - progress));

    // Draws a cubic curve to define the blob shape.
    path.cubicTo(
      size.width * 0.25,
      size.height * (1 - progress * 2),
      size.width * 0.75,
      size.height * (1 - progress * 2),
      size.width,
      size.height * (1 - progress),
    );

    // Closes the path.
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  // Determines whether the clipper should be recalculated.
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Returns true if the progress has changed.
    return oldClipper is _BlobClipper && oldClipper.progress != progress;
  }
}
