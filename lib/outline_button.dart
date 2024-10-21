import 'package:flutter/material.dart';

class AnimatedOutlineButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;

  const AnimatedOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  _AnimatedOutlineButtonState createState() => _AnimatedOutlineButtonState();
}

class _AnimatedOutlineButtonState extends State<AnimatedOutlineButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Color?>? _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Total time for one complete cycle
    )..repeat(); // Repeat infinitely

    // Define a sequence of color transitions
    _colorAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.blue, end: Colors.green),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.green, end: Colors.yellow),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.yellow, end: Colors.orange),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.orange, end: Colors.red),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.red, end: Colors.purple),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.purple, end: Colors.blue),
          weight: 1.0,
        ),
      ],
    ).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: _colorAnimation!.value ??
                  Colors.blue, // animated border color
              width: 2,
            ),
          ),
          onPressed: widget.onPressed, // use the onPressed passed to widget
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 19.0,
              fontWeight: FontWeight.w500,
            ),
          ), // use the title passed to widget
        );
      },
    );
  }
}
