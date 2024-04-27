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

// A StatefulWidget that performs a zooming animation on its child widget.
class ZoomingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag indicating whether the animation should repeat.
  final bool repeat;

  // Constructor for the ZoomingAnimation widget.
  const ZoomingAnimation({
    super.key,
    required this.child,
    required this.duration,
    // Default value for repeat is true.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<ZoomingAnimation> createState() => _ZoomingAnimationState();
}

// The state class for the ZoomingAnimation widget.
class _ZoomingAnimationState extends State<ZoomingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the zooming animation.
  late final AnimationController _controller;

  // The animation that drives the zooming effect.
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

    // Creates a tween animation that scales from 1 to 1.5.
    _animation = Tween<double>(begin: 1, end: 1.5).animate(
      // Uses a curved animation with an ease-in-out curve.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

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

  // Builds the animated widget.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // The animation that drives the build.
      animation: _animation,
      // The builder function that creates the animated widget.
      builder: (context, child) {
        // Scales the child widget using the current animation value.
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
      // The child widget to be animated.
      child: widget.child,
    );
  }
}
