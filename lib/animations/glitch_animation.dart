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

// A custom StatefulWidget that creates a glitch animation effect on its child widget.
class GlitchAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A boolean indicating whether the animation should repeat or not. Defaults to true.
  final bool repeat;

  // Constructor for the GlitchAnimation widget.
  const GlitchAnimation({
    super.key,
    required this.child,
    required this.duration,
    this.repeat = true, // Default value for repeat is true.
  });

  // Creates the state for the GlitchAnimation widget.
  @override
  State<GlitchAnimation> createState() => _GlitchAnimationState();
}

// The state class for the GlitchAnimation widget.
class _GlitchAnimationState extends State<GlitchAnimation> with TickerProviderStateMixin {
  // The animation controller for the glitch animation.
  late final AnimationController _controller;

  // The animation object that defines the animation curve.
  late final Animation<double> _animation;

  // Initializes the state of the GlitchAnimation widget.
  @override
  void initState() {
    super.initState();

    // Creates an AnimationController with the specified duration and vsync.
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Creates a Tween animation that animates from 0 to 1.
    _animation = Tween<double>(begin: 0, end: 1).animate(
      // Uses a CurvedAnimation to define the animation curve.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Uses an ease-in-out curve for the animation.
      ),
    );

    // If the repeat flag is true, repeats the animation in reverse.
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

  // Builds the widget tree for the GlitchAnimation widget.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // The animation object that drives the animation.
      animation: _animation,

      // The builder function that builds the widget tree.
      builder: (context, child) {
        return Stack(
          children: [
            // Creates three Positioned widgets with the child widget,
            // each with a different offset based on the animation value.
            Positioned(
              left: _animation.value * 10,
              child: widget.child,
            ),
            Positioned(
              top: _animation.value * 10,
              child: widget.child,
            ),
            Positioned(
              right: _animation.value * 10,
              child: widget.child,
            ),
          ],
        );
      },

      // The child widget to be animated.
      child: widget.child,
    );
  }
}