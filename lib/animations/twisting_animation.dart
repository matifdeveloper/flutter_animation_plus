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

// A custom StatefulWidget that performs a twisting animation on its child widget.
class TwistingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag indicating whether the animation should repeat.
  final bool repeat;

  // Constructor for TwistingAnimation.
  const TwistingAnimation({
    // The key for the widget.
    super.key,
    // The required child widget.
    required this.child,
    // The required duration of the animation.
    required this.duration,
    // The repeat flag, defaulting to true.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<TwistingAnimation> createState() => _TwistingAnimationState();
}

// The state class for TwistingAnimation.
class _TwistingAnimationState extends State<TwistingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the twisting animation.
  late final AnimationController _controller;

  // The animation that drives the twisting transformation.
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

    // Creates a tween animation that animates from 0 to 2 * pi.
    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      // Uses a curved animation with an ease-in-out curve.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // If the repeat flag is true, repeats the animation indefinitely.
    if (widget.repeat) {
      _controller.repeat();
    } else {
      // Otherwise, plays the animation once.
      _controller.forward();
    }
  }

  // Disposes of the animation controller when the state is disposed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the animated widget.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // The animation that drives the build.
      animation: _animation,
      // The builder function that creates the animated widget.
      builder: (context, child) {
        return Transform(
          // The alignment of the transformation.
          alignment: Alignment.center,
          // The transformation matrix.
          transform: Matrix4.identity()
            // Sets the perspective entry to create a 3D effect.
            ..setEntry(3, 2, 0.001)
            // Rotates the child around the X-axis by the animation value.
            ..rotateX(_animation.value)
            // Rotates the child around the Y-axis by the animation value.
            ..rotateY(_animation.value),
          // The child widget to be transformed.
          child: widget.child,
        );
      },
      // The child widget to be animated.
      child: widget.child,
    );
  }
}
