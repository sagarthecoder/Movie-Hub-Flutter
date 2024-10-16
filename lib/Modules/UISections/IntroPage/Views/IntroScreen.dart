import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';
import 'WavePainter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            buildIntroDescription(context),
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
          height: 430,
        ),
      ),
    );
  }

  Widget buildIntroDescription(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.movie_hub,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.movie_hub_intro_description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14, color: Colors.white38, letterSpacing: 1),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  AppLocalizations.of(context)!.get_started,
                  style: const TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
