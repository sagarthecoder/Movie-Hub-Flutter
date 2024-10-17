import 'package:flutter/material.dart';
import 'NetworkImageView.dart';

class FadingImageSlider extends StatefulWidget {
  final List<String> imagePaths;
  final Duration fadeDuration;
  final Duration displayDuration;

  FadingImageSlider({
    Key? key,
    required this.imagePaths,
    this.fadeDuration = const Duration(seconds: 2),
    this.displayDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  _FadingImageSliderState createState() => _FadingImageSliderState();
}

class _FadingImageSliderState extends State<FadingImageSlider> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startImageTransition();
  }

  void _startImageTransition() {
    Future.delayed(widget.displayDuration, () {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.imagePaths.length;
        });

        Future.delayed(widget.fadeDuration, () {
          _startImageTransition();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.fadeDuration,
      child: NetworkImageView(
        key: ValueKey<int>(_currentIndex),
        url: widget.imagePaths[_currentIndex],
      ),
    );
  }
}
