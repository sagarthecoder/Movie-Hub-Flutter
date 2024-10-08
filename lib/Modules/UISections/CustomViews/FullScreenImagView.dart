import 'package:flutter/cupertino.dart';

class FullScreenImageView extends StatelessWidget {
  final String imagePath;
  FullScreenImageView({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return _setFullScreenBackgroundImage();
  }

  Widget _setFullScreenBackgroundImage() {
    return Image.asset(
      imagePath,
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
