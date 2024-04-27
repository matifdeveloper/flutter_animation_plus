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

// A custom StatefulWidget that performs a shaking animation on its child widget.
class ShakingAnimation extends StatefulWidget {
  // The child widget to be animated.
  final Widget child;

  // The duration of the animation.
  final Duration duration;

  // A flag indicating whether the animation should repeat.
  final bool repeat;

  // Constructor for the ShakingAnimation widget.
  const ShakingAnimation({
    super.key,
    required this.child,
    required this.duration,
    // Default value for repeat is true.
    this.repeat = true,
  });

  // Creates the state for this widget.
  @override
  State<ShakingAnimation> createState() => _ShakingAnimationState();
}

// The state class for the ShakingAnimation widget.
class _ShakingAnimationState extends State<ShakingAnimation>
    with TickerProviderStateMixin {
  // The animation controller for the shaking animation.
  late final AnimationController _controller;

  // The animation that drives the shaking motion.
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

    // Creates a tween animation that goes from 0 to 0.1, with an ease-in-out curve.
    _animation = Tween<double>(begin: 0, end: 0.1)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

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

  // Builds the widget tree.
  @override
  Widget build(BuildContext context) {
    // Uses an AnimatedBuilder to rebuild the widget tree when the animation changes.
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Translates the child widget by the current animation value.
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: widget.child,
        );
      },
      child: widget.child,
    );
  }
}
