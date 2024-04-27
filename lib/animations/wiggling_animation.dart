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

// A custom StatefulWidget that performs a wiggling animation on its child widget.
class WigglingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag indicating whether the animation should repeat.
  final bool repeat;

  // Constructor for WigglingAnimation.
  const WigglingAnimation({
    // The key for the widget.
    super.key,
    // The required child widget.
    required this.child,
    // The required duration of the animation.
    required this.duration,
    // The repeat flag, defaulting to true if not provided.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<WigglingAnimation> createState() => _WigglingAnimationState();
}

// The state class for WigglingAnimation.
class _WigglingAnimationState extends State<WigglingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the wiggling animation.
  late final AnimationController _controller;

  // The animation that drives the wiggling effect.
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

    // Creates a tween animation that varies from -0.1 to 0.1,
    // which will be used to rotate the child widget.
    _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
      // Uses a curved animation with an ease-in-out curve.
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // If the repeat flag is true, sets the animation controller to repeat indefinitely.
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
    // Uses an AnimatedBuilder to rebuild the widget tree when the animation changes.
    return AnimatedBuilder(
      // The animation that drives the rebuild.
      animation: _animation,
      // The builder function that creates the animated widget.
      builder: (context, child) {
        // Rotates the child widget by the current animation value.
        return Transform.rotate(
          angle: _animation.value,
          child: widget.child,
        );
      },
      // The child widget to be animated.
      child: widget.child,
    );
  }
}
