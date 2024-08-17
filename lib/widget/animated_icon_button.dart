import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton({
    required this.icon,
    required this.onPressed,
    required this.animationType,
    super.key,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final AnimationType animationType;

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => _transform(child),
      child: IconButton(
        icon: widget.icon,
        onPressed: () {
          if (_controller.isAnimating) return;
          widget.onPressed();
          _controller.forward(from: 0);
        },
      ),
    );
  }

  Widget _transform(Widget? child) {
    switch (widget.animationType) {
      case AnimationType.rotate:
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Add perspective
            ..rotateY(_animation.value * pi),
          alignment: Alignment.center,
          child: child,
        );
      case AnimationType.giroRight:
        return Transform.rotate(
          angle: _animation.value * 2 * pi, // Rotate from 0 to 360 degrees
          child: child,
        );
      case AnimationType.giroLeft:
        return Transform.rotate(
          angle: -_animation.value * 2 * pi, // Rotate from 0 to 360 degrees
          child: child,
        );
    }
  }
}

enum AnimationType { rotate, giroRight, giroLeft }
