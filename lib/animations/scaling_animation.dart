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

// A StatefulWidget that performs a scaling animation on its child widget.
class ScalingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag indicating whether the animation should repeat.
  final bool repeat;

  // Constructor for the ScalingAnimation widget.
  const ScalingAnimation({
    super.key,
    required this.child,
    required this.duration,
    // Default value for repeat is true.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<ScalingAnimation> createState() => _ScalingAnimationState();
}

// The state class for the ScalingAnimation widget.
class _ScalingAnimationState extends State<ScalingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the scaling animation.
  late final AnimationController _controller;

  // The animation object that defines the scaling animation.
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

    // Creates a Tween animation that scales from 1 to 1.2.
    _animation = Tween<double>(begin: 1, end: 1.2).animate(_controller);

    // If repeat is true, sets the animation to repeat in reverse.
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

  // Builds the widget tree for the ScalingAnimation widget.
  @override
  Widget build(BuildContext context) {
    // Uses an AnimatedBuilder to rebuild the widget tree when the animation changes.
    return AnimatedBuilder(
      // The animation to listen to.
      animation: _animation,

      // The builder function to call when the animation changes.
      builder: (context, child) {
        // Returns a Transform widget that scales the child widget.
        return Transform.scale(
          // The scale factor is the current value of the animation.
          scale: _animation.value,
          child: widget.child,
        );
      },

      // The child widget to be animated.
      child: widget.child,
    );
  }
}
