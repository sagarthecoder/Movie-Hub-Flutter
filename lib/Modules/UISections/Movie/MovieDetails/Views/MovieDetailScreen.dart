import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Helpers/MathHelper.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/NetworkImageView.dart';
import 'package:movie_hub/Modules/UISections/Movie/Favorites/Model/FavoriteRequest.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Model/MovieDetails.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/ViewModel/MovieViewModel.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Views/GenreListView.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Views/MovieDescriptionView.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Views/MovieRatingSection.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieList/Model/MovieInfo.dart';

import '../../../../../Config/MovieApiConfig.dart';

class MovieDetailScreen extends StatelessWidget {
  final Rx<MovieInfo> movieInfo;
  final MovieViewModel viewModel = Get.find<MovieViewModel>();

  MovieDetailScreen({required this.movieInfo, super.key}) {
    viewModel.isLoading.value = false;
    viewModel.movieDetails.value = MovieDetails();
    viewModel.fetchMovieDetails(movieInfo.value.id?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundContainer(context),
          _buildComponents(context),
          _showLoaderIfNeeded(),
        ],
      ),
    );
  }

  Widget _buildComponents(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTopView(context),
          _buildScrollableItems(context),
        ],
      ),
    );
  }

  Widget _showLoaderIfNeeded() {
    return Obx(() {
      if (viewModel.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildBackgroundContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableItems(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 40),
          child: Column(
            children: [
              _showPoster(),
              _buildGenres(),
              _buildMovieDescription(),
              _addFavoriteButton(context),
              _addRating(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 54,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const Center(
            child: Text(
              'Movie Details',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _showPoster() {
    return Obx(() {
      const height = 420.0;
      MovieDetails? details = viewModel.movieDetails.value;
      if (details?.posterPath != null) {
        String url = MovieApiConfig.posterBaseURL + (details?.posterPath ?? "");
        return Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.only(top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: NetworkImageView(url: url),
          ),
        );
      } else {
        return Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.only(top: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: const CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget _buildGenres() {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child:
            GenreListView(genres: viewModel.movieDetails.value?.genres ?? []),
      );
    });
  }

  Widget _buildMovieDescription() {
    return MovieDescriptionView();
  }

  Widget _addFavoriteButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          _didPressedFavoriteButton();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          'Add to Favorite',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }

  void _didPressedFavoriteButton() {
    final movieId = movieInfo.value.id;
    if (movieId == null) {
      return;
    }
    final request =
        FavoriteRequest(mediaId: movieId, mediaType: "movie", favorite: true);
    viewModel.addToFavorite(request);
  }

  Widget _addRating() {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 90,
        child: MovieRatingSection(
          overallRating: viewModel.movieDetails.value?.voteAverage ?? 0.0,
          myRating: MathHelper.getRandomDoubleInRange(1.0, 5.0),
        ),
      );
    });
  }
}
