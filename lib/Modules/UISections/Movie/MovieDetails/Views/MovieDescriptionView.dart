import 'package:flutter/material.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/ViewModel/MovieViewModel.dart';
import 'package:get/get.dart';

import '../Model/MovieDetails.dart';
import 'RoundedTextView.dart';

class MovieDescriptionView extends StatelessWidget {
  final MovieViewModel viewModel = Get.find<MovieViewModel>();

  MovieDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      MovieDetails? details = viewModel.movieDetails.value;
      final theme = Theme.of(context);

      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              details?.originalTitle ?? "",
              style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.colorScheme.onBackground,
                    fontSize: 30,
                  ) ??
                  const TextStyle(color: Colors.white, fontSize: 30),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RoundedTextView(text: details?.releaseDate ?? ""),
                  const SizedBox(width: 20),
                  RoundedTextView(
                    text: viewModel.formatRuntime(details?.runtime),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              details?.overview ?? "",
              style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                    fontSize: 10,
                    letterSpacing: 1,
                  ) ??
                  const TextStyle(color: Colors.white70, fontSize: 10),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ],
        ),
      );
    });
  }
}
