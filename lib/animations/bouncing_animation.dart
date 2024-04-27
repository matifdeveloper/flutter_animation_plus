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

// A custom StatefulWidget that provides a bouncing animation to its child widget.
class BouncingAnimation extends StatefulWidget {
  // The child widget to which the bouncing animation will be applied.
  final Widget child;

  // The duration of the bouncing animation.
  final Duration duration;

  // A boolean indicating whether the animation should repeat or not. Defaults to true.
  final bool repeat;

  // Constructor for the BouncingAnimation widget.
  const BouncingAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = true, // Default value for repeat is true.
  });

  // Creates the state for this widget.
  @override
  State<BouncingAnimation> createState() => _BouncingAnimationState();
}

// The state class for the BouncingAnimation widget.
class _BouncingAnimationState extends State<BouncingAnimation>
    with TickerProviderStateMixin {
  // The animation controller that manages the animation.
  late final AnimationController _controller;

  // The animation that will be used to drive the bouncing effect.
  late final Animation<double> _animation;

  // Initializes the state of the widget.
  @override
  void initState() {
    super.initState();

    // Creates an AnimationController with the specified duration and vsync.
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Creates a CurvedAnimation that will drive the bouncing effect.
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Uses an ease-in-out curve for the animation.
    );

    // If the repeat flag is set, repeats the animation indefinitely.
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

  // Builds the widget tree for the BouncingAnimation widget.
  @override
  Widget build(BuildContext context) {
    // Uses an AnimatedBuilder to rebuild the widget tree when the animation changes.
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Translates the child widget vertically based on the animation value.
        return Transform.translate(
          offset: Offset(0, math.sin(_animation.value * 2 * math.pi) * 50),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
