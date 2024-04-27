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

// A custom StatefulWidget that performs a sliding animation on its child widget.
class SlidingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag indicating whether the animation should repeat.
  final bool repeat;

  // The axis along which the animation should occur (horizontal or vertical).
  final Axis axis;

  // Constructor for the SlidingAnimation widget.
  const SlidingAnimation({
    super.key,
    required this.child,
    required this.duration,
    // Default value for repeat is true.
    this.repeat = true,
    // Default value for axis is Axis.horizontal.
    this.axis = Axis.horizontal,
  });

  // Creates the state for this widget.
  @override
  State<SlidingAnimation> createState() => _SlidingAnimationState();
}

// The state class for the SlidingAnimation widget.
class _SlidingAnimationState extends State<SlidingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the sliding animation.
  late final AnimationController _controller;

  // The animation object that defines the animation's curve and value.
  late final Animation<Offset> _animation;

  // Initializes the state of the widget.
  @override
  void initState() {
    super.initState();
    // Creates an AnimationController with the specified duration and vsync.
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Calculates the begin and end offsets for the animation based on the axis.
    final begin = widget.axis == Axis.horizontal
        ? const Offset(-1, 0)
        : const Offset(0, -1);
    final end = widget.axis == Axis.horizontal
        ? const Offset(1, 0)
        : const Offset(0, 1);

    // Creates a Tween animation that animates from begin to end.
    _animation = Tween<Offset>(begin: begin, end: end).animate(_controller);

    // If repeat is true, sets the animation to repeat indefinitely.
    if (widget.repeat) {
      _controller.repeat(reverse: true);
    } else {
      // Otherwise, starts the animation forward.
      _controller.forward();
    }
  }

  // Disposes of the animation controller when the widget is removed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the widget tree for the SlidingAnimation widget.
  @override
  Widget build(BuildContext context) {
    // Uses an AnimatedBuilder to rebuild the widget tree when the animation changes.
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Translates the child widget by the current animation offset.
        return Transform.translate(
          offset: _animation.value,
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}