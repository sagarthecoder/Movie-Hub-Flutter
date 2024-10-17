import 'package:flutter/material.dart';
import 'NetworkImageView.dart'; // Your custom widget for displaying network images.

class FadingImageSlider extends StatefulWidget {
  final List<String> imagePaths; // List of image paths or URLs
  final Duration fadeDuration; // Duration for fading in/out
  final Duration displayDuration; // Duration for displaying each image

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
  int _currentIndex = 0; // Current image index

  @override
  void initState() {
    super.initState();
    _startImageTransition();
  }

  void _startImageTransition() {
    Future.delayed(widget.displayDuration, () {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) %
              widget.imagePaths.length; // Move to the next image
        });

        Future.delayed(widget.fadeDuration, () {
          _startImageTransition(); // Start the next transition
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.fadeDuration,
      child: NetworkImageView(
        key:
            ValueKey<int>(_currentIndex), // Key to differentiate between images
        url: widget.imagePaths[_currentIndex], // Display current image
      ),
    );
  }
}
