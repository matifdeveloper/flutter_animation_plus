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

// A StatefulWidget that creates a pulsing animation effect on its child widget.
class PulsingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A boolean indicating whether the animation should repeat.
  final bool repeat;

  // Constructor for PulsingAnimation.
  const PulsingAnimation({
    // The key for the widget.
    super.key,
    // The required child widget.
    required this.child,
    // The required duration of the animation.
    required this.duration,
    // Whether the animation should repeat, default is true.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<PulsingAnimation> createState() => _PulsingAnimationState();
}

// The state for the PulsingAnimation widget.
class _PulsingAnimationState extends State<PulsingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the pulsing animation.
  late final AnimationController _controller;

  // The animation that scales the child widget.
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

    // Creates a tween animation that scales from 1 to 1.2.
    _animation = Tween<double>(begin: 1, end: 1.2).animate(
      // Uses a curved animation with an ease-in-out curve.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // If the animation should repeat, sets the controller to repeat in reverse.
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

  // Builds the animated widget.
  @override
  Widget build(BuildContext context) {
    // Uses an AnimatedBuilder to rebuild the widget when the animation changes.
    return AnimatedBuilder(
      // The animation to listen to.
      animation: _animation,
      // The builder function to create the animated widget.
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
