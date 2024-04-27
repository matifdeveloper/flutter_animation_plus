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

    Created by Muhammad Atif on 4/26/2024.
    Portfolio https://atifnoori.web.app.
    IsloAI

 *********************************************************************************/

import 'package:flutter/material.dart';

// A StatefulWidget that performs a morphing animation on its child widget.
class MorphingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // Whether the animation should repeat or not. Defaults to true.
  final bool repeat;

  // Constructor for MorphingAnimation.
  const MorphingAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<MorphingAnimation> createState() => _MorphingAnimationState();
}

// The state for the MorphingAnimation widget.
class _MorphingAnimationState extends State<MorphingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the animation.
  late final AnimationController _controller;

  // The animation that drives the morphing effect.
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
        // Creates a ClipPath widget with a custom clipper that morphs the child.
        return ClipPath(
          // The clipper that performs the morphing effect.
          clipper: _MorphingClipper(
            // The progress of the animation, which drives the morphing effect.
            progress: _animation.value,
          ),
          // The child widget to be morphed.
          child: widget.child,
        );
      },
      // The child widget to be morphed.
      child: widget.child,
    );
  }
}

// A custom clipper that morphs a rectangle based on the animation progress.
class _MorphingClipper extends CustomClipper<Path> {
  // The progress of the animation, which drives the morphing effect.
  final double progress;

  // Constructor for _MorphingClipper.
  _MorphingClipper({
    required this.progress,
  });

  // Returns the clipping path for the morphing effect.
  @override
  Path getClip(Size size) {
    // Creates a new path for the clipping.
    final path = Path();

    // Moves the path to the starting point of the morphing effect.
    path.moveTo(0, size.height * (1 - progress));

    // Draws the morphed rectangle based on the animation progress.
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * (1 - progress));

    // Closes the path.
    path.close();

    // Returns the clipping path.
    return path;
  }

  // Determines whether the clipper should be recalculated.
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Returns true if the old clipper is a _MorphingClipper and its progress is different.
    return oldClipper is _MorphingClipper && oldClipper.progress!= progress;
  }
}