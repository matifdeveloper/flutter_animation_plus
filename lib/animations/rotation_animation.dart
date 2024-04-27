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
import 'dart:math' as math;

// A StatefulWidget that rotates its child widget over a specified duration.
class RotatingAnimation extends StatefulWidget {
  // The child widget to be rotated.
  final Widget child;

  // The duration of the rotation animation.
  final Duration duration;

  // A boolean indicating whether the animation should repeat indefinitely.
  final bool repeat;

  // Constructor for RotatingAnimation.
  const RotatingAnimation({
    // The key for this widget.
    super.key,
    // The required child widget.
    required this.child,
    // The required duration of the animation.
    required this.duration,
    // Whether the animation should repeat (defaults to true).
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<RotatingAnimation> createState() => _RotatingAnimationState();
}

// The state for the RotatingAnimation widget.
class _RotatingAnimationState extends State<RotatingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the rotation animation.
  late final AnimationController _controller;

  // The animation that drives the rotation.
  late final Animation<double> _animation;

  // Initializes the state.
  @override
  void initState() {
    super.initState();
    // Creates an animation controller with the specified duration and vsync.
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Creates a tween animation that goes from 0 to 2 * pi (a full circle).
    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);

    // If the animation should repeat, sets the controller to repeat indefinitely.
    if (widget.repeat) {
      _controller.repeat();
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
      // The animation that drives the rebuild.
      animation: _animation,
      // The builder function that creates the widget tree.
      builder: (context, child) {
        // Returns a Transform widget that rotates the child by the current animation value.
        return Transform.rotate(
          // The angle of rotation (in radians).
          angle: _animation.value,
          // The child widget to be rotated.
          child: widget.child,
        );
      },
      // The child widget to be rotated.
      child: widget.child,
    );
  }
}
