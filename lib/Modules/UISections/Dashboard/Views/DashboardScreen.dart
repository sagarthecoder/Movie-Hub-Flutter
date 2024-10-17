import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Config/MovieApiConfig.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/FadingImageSlider.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/ViewModel/MovieViewModel.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/Views/MovieViewer.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieDetails/Views/MovieDetailScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatelessWidget {
  final MovieViewModel viewModel = Get.put(MovieViewModel());

  DashboardScreen({super.key}) {
    viewModel.fetchTopRatedMovies();
    viewModel.fetchUpcomingMovies();
    viewModel.fetchMovieDetails('278');
    viewModel.fetchFavoriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary.withOpacity(0.38),
                ],
              ),
            ),
          ),
          _displayOnScreenWidget(context),
        ],
      ),
    );
  }

  Widget _displayOnScreenWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildUserInfo(context),
            _buildImageAnimations(),
            _buildTopRatedMovies(context),
            _buildUpcomingMovies(context),
            _buildMyFavoriteMovies(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcome_back,
              style: TextStyle(
                fontSize: 9,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white,
              ),
            ),
            const Text(
              'Sagar Das',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageAnimations() {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 300,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: FadingImageSlider(
          imagePaths: viewModel.topRatedMovieList
              .where((item) => item.posterPath != null)
              .map((item) => MovieApiConfig.posterBaseURL + item.posterPath!)
              .toList(),
        ),
      );
    });
  }

  Widget _buildTopRatedMovies(BuildContext context) {
    return Obx(() {
      if (viewModel.topRatedMovieList.isNotEmpty) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: MovieViewer(
            movieItemCallback: (item) {
              Get.to(() => MovieDetailScreen(movieInfo: item.obs));
            },
            title: AppLocalizations.of(context)!.top_rated_movies,
            movieItems: viewModel.topRatedMovieList,
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        );
      }
    });
  }

  Widget _buildUpcomingMovies(BuildContext context) {
    return Obx(() {
      if (viewModel.upcomingMovieList.isNotEmpty) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: MovieViewer(
            movieItemCallback: (item) {
              Get.to(() => MovieDetailScreen(movieInfo: item.obs));
            },
            title: AppLocalizations.of(context)!.upcoming_movies,
            movieItems: viewModel.upcomingMovieList,
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.pink,
          ),
        );
      }
    });
  }

  Widget _buildMyFavoriteMovies(BuildContext context) {
    return Obx(() {
      if (viewModel.favoriteMovieList.isNotEmpty) {
        return Container(
          margin: const EdgeInsets.only(top: 30),
          child: MovieViewer(
            movieItemCallback: (item) {
              Get.to(() => MovieDetailScreen(movieInfo: item.obs));
            },
            title: AppLocalizations.of(context)!.my_favorites,
            movieItems: viewModel.favoriteMovieList,
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
