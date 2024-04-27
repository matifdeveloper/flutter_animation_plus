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


// A StatefulWidget that performs a flip animation on its child widget.
class FlipAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // Whether the animation should repeat or not. Defaults to true.
  final bool repeat;

  // Constructor for FlipAnimation.
  const FlipAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = true, // default value for repeat
  });

  // Creates the state for this widget.
  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

// The state for the FlipAnimation widget.
class _FlipAnimationState extends State<FlipAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the flip animation.
  late final AnimationController _controller;

  // The animation that drives the flip animation.
  late final Animation<double> _animation;

  // Initializes the state.
  @override
  void initState() {
    super.initState();

    // Creates an AnimationController with the specified duration and vsync.
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Creates a Tween animation that animates from 0 to pi (180 degrees).
    _animation = Tween<double>(begin: 0, end: math.pi).animate(
      // Uses a CurvedAnimation to apply an ease-in-out curve to the animation.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // If repeat is true, repeats the animation indefinitely with a reverse animation.
    if (widget.repeat) {
      _controller.repeat(reverse: true);
    } else {
      // Otherwise, plays the animation forward once.
      _controller.forward();
    }
  }

  // Disposes of the animation controller when the widget is disposed.
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
        // Creates a Transform widget that applies a 3D rotation to its child.
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // sets the perspective
            ..rotateY(_animation.value), // rotates the child around the Y-axis
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}