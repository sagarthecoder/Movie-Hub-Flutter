import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WavePainter.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            setFullScreenBackgroundImage(),
            makeWave(),
            buildIntroDescription(),
          ],
        ),
      ),
    );
  }

  Widget setFullScreenBackgroundImage() {
    return Image.asset(
      "utils/images/movie-watching.jpeg",
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget makeWave() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ClipPath(
        clipper: WavePainter(),
        child: Container(
          color: Colors.grey,
          height: 450,
        ),
      ),
    );
  }

  Widget buildIntroDescription() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Movie Hub',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Welcome to Movie-hub.\n Here you will get latest and old movies\nWatch them and enjoy!!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10, color: Colors.white38, letterSpacing: 1),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Get Startted',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
