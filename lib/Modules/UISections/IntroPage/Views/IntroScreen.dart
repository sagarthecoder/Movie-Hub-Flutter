import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';
import 'WavePainter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: theme.colorScheme.background,
        child: Stack(
          children: [
            setFullScreenBackgroundImage(),
            makeWave(theme.colorScheme),
            buildIntroDescription(context, theme),
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

  Widget makeWave(ColorScheme colorScheme) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ClipPath(
        clipper: WavePainter(),
        child: Container(
          color: colorScheme.primary,
          height: 430,
        ),
      ),
    );
  }

  Widget buildIntroDescription(BuildContext context, ThemeData theme) {
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
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.movie_hub_intro_description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.7),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => LoginScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.get_started,
                style: TextStyle(color: theme.colorScheme.onSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
