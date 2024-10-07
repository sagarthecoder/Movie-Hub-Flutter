import 'package:flutter/cupertino.dart';

class WavePainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.moveTo(0, size.height * 0.6);
    // path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.1,
        size.width * 0.5, size.height * 0.12);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.15, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
