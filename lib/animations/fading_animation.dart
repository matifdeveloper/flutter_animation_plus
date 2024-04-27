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

// A custom StatefulWidget that performs a fading animation on its child widget.
class FadingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag indicating whether the animation should repeat.
  final bool repeat;

  // Constructor for FadingAnimation.
  const FadingAnimation({
    // The key for the widget.
    super.key,
    // The required child widget.
    required this.child,
    // The required duration of the animation.
    required this.duration,
    // The optional repeat flag, defaulting to true.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<FadingAnimation> createState() => _FadingAnimationState();
}

// The state class for FadingAnimation.
class _FadingAnimationState extends State<FadingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the fading animation.
  late final AnimationController _controller;

  // The animation object that controls the opacity of the child widget.
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

    // Creates a tween animation that animates the opacity from 1 to 0.
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);

    // If the repeat flag is true, sets the animation controller to repeat in reverse.
    if (widget.repeat) {
      _controller.repeat(reverse: true);
    }
    // Otherwise, starts the animation forward.
    else {
      _controller.forward();
    }
  }

  // Disposes of the animation controller when the state is disposed.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Builds the widget tree.
  @override
  Widget build(BuildContext context) {
    // Returns an AnimatedBuilder that rebuilds when the animation changes.
    return AnimatedBuilder(
      // The animation to listen to.
      animation: _animation,
      // The builder function that returns the widget tree.
      builder: (context, child) {
        // Returns an Opacity widget with the current animation value as its opacity.
        return Opacity(
          // The opacity of the child widget, animated by _animation.
          opacity: _animation.value,
          // The child widget to be animated.
          child: widget.child,
        );
      },
      // The child widget to be animated.
      child: widget.child,
    );
  }
}
